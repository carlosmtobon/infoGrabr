//
//  QuestionnaireViewController.m
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/14/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//
#import "InfoGrabrAppDelegate.h"
#import "QuestionnaireViewController.h"
#import "Attendee.h"
#import "AttendeeStore.h"
#import "InfoGrabrJSON.h"

@implementation QuestionnaireViewController

@synthesize servicesPicker, timeFramePickerView;
@synthesize services, timeframes, selectedTime, selectedServices, selectedLyker;
@synthesize clientLead, defaultServices;
@synthesize radioButton1, radioButton2, radioButton3, radioButton4, radioButton5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Add this controller to rootViewController which is a tab bar - p.h, c.t
        self.title = NSLocalizedString(@"Questionnaire", @"Questionnaire");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // backup servicePicker array
    defaultServices = [[NSMutableArray alloc] initWithObjects: @"", nil];
    
    // create default services list - p.h, e.p
    services = [[NSMutableArray alloc] initWithObjects: @"Analysis Consult", @"Biorepository", @"Gene Expression", @"Genotyping", @"Sequencing", nil];
    
    // update services with data from the web
    NSMutableArray* tmp = [InfoGrabrJSON fetchServices];
    if (tmp)
        services = tmp;
    
    defaultServices = services;
    // get original array count before number can potentially change by picker - p.h
    originalCount = services.count;
    
    //[servicesPicker reloadAllComponents];
    //[servicesPicker reloadInputViews];
    //[servicesPicker setNeedsDisplay];
    //[self.view setNeedsDisplay];
   
    // create a UIPickerView that appears as a keyboard
    // array for UIPickerView
    timeframes = [NSArray arrayWithObjects:@"0-3 Months", @"6 Months", @"1 Year", @"Greater than 1 Year", nil];
    
    // allocate memory for a pickerView
    // this pickerView will be for displaying timeFrame when timeFrameDropDown button is pressed
    // pickerView will popup like the keyboard
    self.timeFramePickerView = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.timeFramePickerView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.timeFramePickerView.inputView = pickerView;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    // create two buttons on UIToolbar of pickerView
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    // give pickerView a UIToolBar
    self.timeFramePickerView.inputAccessoryView = toolBar;
    
    
    // allow users to escape text fields by pressing return key - p.h, c.t
    self.confID.delegate = self;
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.organization.delegate = self;
    self.notes.delegate = self;
    self.company.delegate = self;
    self.office.delegate = self;
    self.address.delegate = self;
    self.city.delegate = self;
    self.state.delegate = self;
    self.zipcode.delegate = self;
    self.country.delegate = self;
    self.membership.delegate = self;
    self.phoneOne.delegate = self;
    self.phoneTwo.delegate = self;
    self.email.delegate = self;
    
    // set defaults and alloc - p.h
    // set lykerscale default
    selectedLyker = @"neutral";
    selectedServices = [[NSMutableString alloc] initWithString:@""];
    selectedTime = @"";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated. 
}

-(void)viewDidLayoutSubviews {
    // implement code in order for scrollView to work - p.h
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

-(void)viewWillAppear:(BOOL)animated
{
    // if scanviewcontroller sends an Attendee object over, pre-populate fields - p.h
    if (clientLead != nil)
    {
        self.confID.text = clientLead.confId;
        self.firstName.text = clientLead.firstName;
        self.lastName.text = clientLead.lastName;
        self.organization.text = clientLead.organization;
    }

}

// validate email syntax - p.h
// method is called after user exists text fields
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // chack if the textfield the user exited was the email textfield
    if (textField == self.email)
    {
        if(![self validateEmail:[self.email text]])
        {
            // user entered invalid email address
            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email might not a correct email." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];

        }
    }
}
// return fails if string fails regex
- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

//The number of columns. Both UIPickerViews have only 1 component
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // check if pickerView is servicePicker
    // otherwise its the other pickerView
    if ([pickerView isEqual:servicesPicker])
        return originalCount;
    else
        return [timeframes count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:servicesPicker])
        return [[services objectAtIndex:row] stringValue];
    else
    {
        return [[timeframes objectAtIndex:row] stringValue];
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if ([pickerView isEqual:servicesPicker])
    {
        UITableViewCell *cell = (UITableViewCell *)view;
    
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setBounds: CGRectMake(0, 0, cell.frame.size.width -20 , 44)];
            
            // when servicesPicker is tapped once, toggleSelection method is called
            UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelection:)];
            singleTapGestureRecognizer.numberOfTapsRequired = 1;
            [cell addGestureRecognizer:singleTapGestureRecognizer];
        }
    
        if ([services indexOfObject:[NSNumber numberWithInt:row]] != NSNotFound) {
            UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox-checked.png"]];
            [cell setAccessoryView:checkmark];
            //[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox.png"]];
            [cell setAccessoryView:checkmark];
            //[cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        
        cell.textLabel.text = [services objectAtIndex:row];
        cell.tag = row;
        return cell;
    }
    else // if it is not servicesPicker pickerView, it's another view
    {
        // there is only one other pickerView and that's the picker view the has the time frames selection
        UITableViewCell *cell = (UITableViewCell *)view;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setBounds: CGRectMake(0, 0, cell.frame.size.width -20 , 44)];
        }
        
        cell.textLabel.text = [timeframes objectAtIndex:row];
        cell.tag = row;
        
        return cell;
    }
}

// when a row of servicesPicker is tapped once, append a new object to the end of the array
// the new object is a NSNumber that holds the index of selected element of servicesPicker
- (void)toggleSelection:(UITapGestureRecognizer *)recognizer {
    NSNumber *row = [NSNumber numberWithInt:recognizer.view.tag];
    NSUInteger index = [services indexOfObject:row];
    
    // if element of servicesPicker doesn't have an association
    if (index != NSNotFound) {
        [services removeObjectAtIndex:index];
        UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox.png"]];
        [(UITableViewCell *)(recognizer.view) setAccessoryView:checkmark];//setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [services addObject:row];
        UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox-checked.png"]];
        [(UITableViewCell *)(recognizer.view) setAccessoryView:checkmark];//setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

- (IBAction)saveButton:(id)sender {
    clientLead.projectTimeframe = selectedTime;
    clientLead.extraInfo = self.notes.text;
    clientLead.company = self.company.text;
    clientLead.office = self.office.text;
    clientLead.address = self.address.text;
    clientLead.city = self.city.text;
    clientLead.state = self.state.text;
    clientLead.zipcode = self.zipcode.text;
    clientLead.country = self.country.text;
    clientLead.membership = self.membership.text;
    clientLead.phone1 = self.phoneOne.text;
    clientLead.phone2 = self.phoneTwo.text;
    clientLead.email = self.email.text;
    clientLead.confId = self.confID.text;
    clientLead.firstName = self.firstName.text;
    clientLead.lastName = self.lastName.text;
    clientLead.organization = self.organization.text;

    if (originalCount < [services count])
    {
        for(int i = [services count]; i > originalCount; i--)
        {
            NSNumber* num = (NSNumber*)[services objectAtIndex:(i-1)];
            NSInteger index = [num integerValue];
            
            [selectedServices appendString:[services objectAtIndex:index ] ];
            [selectedServices appendString:@", "];
        }
    }
    
    clientLead.cgtServices = selectedServices;
    
    // pick first conference as conference name
    clientLead.confName = @"Patrick's Conference"; // default in case no internet
    NSMutableArray* tmp = [InfoGrabrJSON fetchConferences];
    if (tmp && tmp.count > 0) // we got conferences
        clientLead.confName = [tmp objectAtIndex:0];
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    clientLead.dateCreated = [dateFormatter stringFromDate:currDate];
    
    clientLead.lykerNum = selectedLyker;
    
    if (clientLead.confName.length > 0 && clientLead.firstName.length > 0 && clientLead.organization.length > 0)
    {
        NSString *tmp = [NSString stringWithFormat:@" %@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@;%@",clientLead.address,clientLead.cgtServices,clientLead.city,clientLead.company,clientLead.confId,clientLead.country,clientLead.email,clientLead.extraInfo,clientLead.firstName,clientLead.lastName,clientLead.membership,clientLead.office,clientLead.organization,clientLead.phone1,clientLead.phone2,clientLead.projectTimeframe,clientLead.state,clientLead.zipcode,clientLead.confName,clientLead.dateCreated,clientLead.lykerNum];
        
        // attempt to push data to the server
        if ([InfoGrabrJSON pushAttendeeInfo:tmp])
        {
            
            alert = [[UIAlertView alloc] initWithTitle:@"Information Saved" message:@"Information was saved successfully to database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Could Not Connect" message:@"Unable to connect at this time. Information will be store on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            [alert show];
            
            //add to coredata
            AttendeeStore* store = [(InfoGrabrAppDelegate*)[[UIApplication sharedApplication]delegate] attendeeStore];
            
            if ([store save])
                NSLog(@"Saved to CoreData");
        }
        
        [self clearForm];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please make sure Conf ID, First Name, Last Name, and Organization fields are filled out." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [alert show];
    }
    
    
    
}

- (IBAction)timeFrameDropDown:(id)sender {
    [self.timeFramePickerView becomeFirstResponder];
}

- (IBAction)clearButton:(id)sender {
    [self clearForm];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (!([pickerView isEqual:servicesPicker]))
    {
        selectTimeRow = row;
    }
}

- (void)cancelTouched:(UIBarButtonItem *)sender
{
    [self.timeFramePickerView resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    [self.timeFramePickerView resignFirstResponder];
    
    selectedTime = [timeframes objectAtIndex:selectTimeRow];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)radioButtonPressed:(id)sender {

    
    [radioButton1 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];

    [radioButton2 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];

    [radioButton3 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];

    [radioButton4 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];

    [radioButton5 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
    
    
    switch ([sender tag]) {
        case 1:
            [radioButton1 setImage:[UIImage imageNamed:@"radiobutton-checked.png"] forState:UIControlStateNormal];
            selectedLyker = @"strongly agree";
            break;
        case 2:
            [radioButton2 setImage:[UIImage imageNamed:@"radiobutton-checked.png"] forState:UIControlStateNormal];
            selectedLyker = @"agree";
            break;
        case 3:
            [radioButton3 setImage:[UIImage imageNamed:@"radiobutton-checked.png"] forState:UIControlStateNormal];
            selectedLyker = @"neutral";
            break;
        case 4:
            [radioButton4 setImage:[UIImage imageNamed:@"radiobutton-checked.png"] forState:UIControlStateNormal];
            selectedLyker = @"disagree";
            break;
        case 5:
            [radioButton5 setImage:[UIImage imageNamed:@"radiobutton-checked.png"] forState:UIControlStateNormal];
            selectedLyker = @"strongly disagree";
            break;
    }
}

-(void)clearForm
{
    selectedTime = @"";
    self.notes.text = @"";
    self.company.text = @"";
    self.office.text = @"";
    self.address.text = @"";
    self.city.text = @"";
    self.state.text = @"";
    self.zipcode.text = @"";
    self.country.text = @"";
    self.membership.text = @"";
    self.phoneOne.text = @"";
    self.phoneTwo.text = @"";
    self.email.text = @"";
    self.confID.text = @"";
    self.firstName.text = @"";
    self.lastName.text = @"";
    self.organization.text = @"";
    clientLead.confId = @"";
    clientLead.firstName = @"";
    clientLead.lastName = @"";
    clientLead.organization = @"";
    clientLead.projectTimeframe = @"";
    clientLead.extraInfo = @"";
    clientLead.company = @"";
    clientLead.office = @"";
    clientLead.address = @"";
    clientLead.city = @"";
    clientLead.state = @"";
    clientLead.zipcode = @"";
    clientLead.country = @"";
    clientLead.membership = @"";
    clientLead.phone1 = @"";
    clientLead.phone2 = @"";
    clientLead.email = @"";
    selectedLyker = @"neutral";
    
    [selectedServices setString:@""];
    
    [radioButton1 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
    
    [radioButton2 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
    
    [radioButton3 setImage:[UIImage imageNamed:@"radiobutton-checked.png"] forState:UIControlStateNormal];
    
    [radioButton4 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
    
    [radioButton5 setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
    
}

@end
