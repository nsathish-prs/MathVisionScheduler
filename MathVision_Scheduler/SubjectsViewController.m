//
//  SubjectsViewController.m
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import "SubjectsViewController.h"

@interface SubjectsViewController ()

@end

@implementation SubjectsViewController
@synthesize course,grade,picker,pickerView,donePickerView;
NSDictionary *results;
NSMutableArray *resultsArray;
Boolean flag;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPicker:course];
    resultsArray = [[NSMutableArray alloc] init];
   
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://192.168.1.39/SchedulerService/Service.svc/GetCourseList"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //            NSLog(@"%@", results);
        [resultsArray removeAllObjects];
        [resultsArray addObject:@"Select Course"];
        for (NSDictionary *item in results) {
            //                NSLog(@"%@ %@", [item objectForKey:@"CourseId"], [item objectForKey:@"Description"]);
            [resultsArray  addObject:[item objectForKey:@"Description"] ];
        }
        NSLog(@"%@",resultsArray);
        flag = true;
        
    }];
    [dataTask resume];
 [course becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [course resignFirstResponder];
//    [grade resignFirstResponder];
//    return YES;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loadPicker:(id)sender {
    [course resignFirstResponder];
    [grade resignFirstResponder];
    if ([sender isEqual:course]) {
        NSLog(@"Course");
        [resultsArray removeAllObjects];
        [resultsArray addObject:@"Select Course"];
        for (NSDictionary *item in results) {
            //                NSLog(@"%@ %@", [item objectForKey:@"CourseId"], [item objectForKey:@"Description"]);
            [resultsArray  addObject:[item objectForKey:@"Description"] ];
        }
        NSLog(@"%@",resultsArray);
        flag = true;

    }else if ([sender isEqual:grade]){
        NSLog(@"Grade");
        [resultsArray removeAllObjects];
        [resultsArray addObject:@"Select Grade"];
        [resultsArray addObject: @"Grade 1"];
        [resultsArray addObject: @"Grade 2"];
        [resultsArray addObject: @"Grade 3"];
        [resultsArray addObject: @"Grade 4"];
        [resultsArray addObject: @"Grade 5"];
        [resultsArray addObject: @"Grade 6"];
        [resultsArray addObject: @"Grade 7"];
        [resultsArray addObject: @"Grade 8"];
        [resultsArray addObject: @"Grade 9"];
        [resultsArray addObject: @"Grade 10"];
        [resultsArray addObject: @"Grade 11"];
        [resultsArray addObject: @"Grade 12"];
        [resultsArray addObject: @"University"];
        flag = false;
    }
    [picker reloadAllComponents];
    [UIView beginAnimations:Nil context:NULL];
    CGRect frame = pickerView.bounds;
    frame.origin.y = 347.0f;
    [UIView setAnimationDuration:0.3];
    
    [self.picker selectRow:0 inComponent:0 animated:YES];
    [UIView commitAnimations];
}

- (IBAction)closePickerView{
    [UIView beginAnimations:Nil context:NULL];
    pickerView.frame = CGRectMake(0, 847, 800, 206);
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
    [resultsArray removeAllObjects];
    [resultsArray addObject:@"Select Course"];
    [picker reloadAllComponents];
    
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [resultsArray count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return[resultsArray objectAtIndex:row];
}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (flag) {
        if ([[resultsArray objectAtIndex:row] isEqualToString:@"Select Course"]) {
            course.text= @"";
        } else {
            course.text=[resultsArray objectAtIndex:row];
        }
    }else{
        if ([[resultsArray objectAtIndex:row] isEqualToString:@"Select Grade"]) {
            grade.text= @"";
        } else {
            grade.text=[resultsArray objectAtIndex:row];
        }
    }
}
@end
