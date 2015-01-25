//
//  CourseViewController.h
//  MathVision_Scheduler
//
//  Created by Math Vision on 24/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectsViewController.h"

@interface CourseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet SubjectsViewController *subjects;

- (IBAction)dismissView:(id)sender;
@end
