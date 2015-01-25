//
//  OptionsViewController.h
//  MathVision_Scheduler
//
//  Created by Math Vision on 25/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textArea;


- (IBAction)submitOption:(id)sender;


@end
