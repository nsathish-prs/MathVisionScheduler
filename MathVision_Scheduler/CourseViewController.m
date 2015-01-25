//
//  CourseViewController.m
//  MathVision_Scheduler
//
//  Created by Math Vision on 24/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import "CourseViewController.h"
#import "DataModel.h"

@interface CourseViewController ()

@end

@implementation CourseViewController
DataModel *dm;

@synthesize tableView,subjects;

NSMutableArray *courseIdArray;
NSMutableArray *courseDescArray;

NSDictionary *courseResults;

- (void)viewDidLoad {
    [super viewDidLoad];
    subjects.view.alpha = 0.5f;
    courseDescArray = [[NSMutableArray alloc]init];
    courseIdArray = [[NSMutableArray alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GetCourseList",dm.URL]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        courseResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [courseIdArray removeAllObjects];
        [courseDescArray removeAllObjects];
        for (NSDictionary *item in courseResults) {
            [courseIdArray  addObject:[item objectForKey:@"CourseId"] ];
            [courseDescArray  addObject:[item objectForKey:@"Description"] ];

        }
        NSLog(@"%@",courseResults);
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    [dataTask resume];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView:)];
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [courseIdArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"Cell"];
    }
    [[cell textLabel] setText:[courseDescArray objectAtIndex:[indexPath row]]];
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dm.course = [courseIdArray objectAtIndex:indexPath.row];
    [subjects loadSubjectsForCourse:dm.course];
    subjects.view.alpha = 1.0f;
    subjects.CourseText.titleLabel.text = dm.course;
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)dismissView:(id)sender {
    subjects.view.alpha = 1.0f;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
