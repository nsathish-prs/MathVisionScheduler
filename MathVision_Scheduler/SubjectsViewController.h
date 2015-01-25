//
//  SubjectsViewController.h
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectsViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    }

@property (weak, nonatomic) IBOutlet UITableView *tableViewSubjects;
@property (weak, nonatomic) IBOutlet UIButton *CourseText;


- (void) loadSubjectsForCourse:(NSString*)courseID;

@end

