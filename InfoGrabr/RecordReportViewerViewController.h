//
//  RecordReportViewerViewController.h
//  InfoGrabr
//
//  Created by enio pena navarro on 4/23/14.
//  Copyright (c) 2014 Florida International University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordReportViewerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray* reportData;
@end
