//
//  QuestionnaireViewController.m
//  InfoGrabr
//
//  Created by patrick ramiro halsall on 4/14/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "QuestionnaireServices.h"

@implementation QuestionnaireViewController

@synthesize servicesPicker;
@synthesize services;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return originalCount;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[services objectAtIndex:row] stringValue];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
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
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    cell.textLabel.text = [services objectAtIndex:row];
    cell.tag = row;
    
    return cell;
}

- (void)toggleSelection:(UITapGestureRecognizer *)recognizer {
    NSNumber *row = [NSNumber numberWithInt:recognizer.view.tag];
    NSUInteger index = [services indexOfObject:row];
    if (index != NSNotFound) {
        [services removeObjectAtIndex:index];
        [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [services addObject:row];
        [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

@end
