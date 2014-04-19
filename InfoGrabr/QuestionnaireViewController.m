//
//  QuestionnaireViewController.m
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/14/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "QuestionnaireServices.h"
#import "Attendee.h"

@implementation QuestionnaireViewController

@synthesize servicesPicker, timeFramePickerView;
@synthesize services, timeframes;
@synthesize clientLead;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Questionnaire", @"Questionnaire");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sharedServices = [[QuestionnaireServices alloc] init];
    
    services = [sharedServices services];
    
    originalCount = services.count;
    
    timeframes = [NSArray arrayWithObjects:@"0-3 Months", @"6 Months", @"1 Year", @"Greater than 1 Year", nil];
    
    
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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.timeFramePickerView.inputAccessoryView = toolBar;
    
    
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
    
    if (clientLead != nil)
    {
        self.confID.text = clientLead.confId;
        self.firstName.text = clientLead.firstName;
        self.lastName.text = clientLead.lastName;
        self.organization.text = clientLead.organization;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated. 
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}


//The number of columns. Both UIPickerViews have only 1 component
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
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
    else
    {
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

- (void)toggleSelection:(UITapGestureRecognizer *)recognizer {
    NSNumber *row = [NSNumber numberWithInt:recognizer.view.tag];
    NSUInteger index = [services indexOfObject:row];
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
    
    
}

- (IBAction)timeFrameDropDown:(id)sender {
    [self.timeFramePickerView becomeFirstResponder];
}

- (void)cancelTouched:(UIBarButtonItem *)sender
{
    [self.timeFramePickerView resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    [self.timeFramePickerView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
