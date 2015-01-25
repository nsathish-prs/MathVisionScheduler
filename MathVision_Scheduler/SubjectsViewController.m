//
//  SubjectsViewController.m
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import "SubjectsViewController.h"
#import "DataModel.h"
#import "CourseViewController.h"

@interface SubjectsViewController ()

@end

@implementation SubjectsViewController
DataModel *dm;


@synthesize tableViewSubjects,CourseText;

NSDictionary *subjectResults;
NSMutableArray *subjectsIdArray;
NSMutableArray *subjectsDescArray;


- (void)viewDidLoad {
    [super viewDidLoad];
   
    subjectsIdArray = [[NSMutableArray alloc] init];
    subjectsDescArray = [[NSMutableArray alloc]init];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [self.tableViewSubjects reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}


- (void) loadSubjectsForCourse:(NSString*)courseID {
    NSURLSession *session = [NSURLSession sharedSession];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@/GetSubjects/%@/%@",dm.URL,courseID,gradeID]);
    [subjectsIdArray removeAllObjects];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GetSubjects/%@",dm.URL,courseID]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        subjectResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", subjectResults);
        [subjectsIdArray removeAllObjects];
        for (NSDictionary *item in subjectResults) {
            [subjectsIdArray  addObject:[item objectForKey:@"SubjectId"]];
            [subjectsDescArray addObject:[item objectForKey:@"Description"]];
        }
        NSLog(@"%@",subjectsIdArray);
        [self.tableViewSubjects performSelectorOnMainThread:@selector(reloadData)  withObject:nil waitUntilDone:YES];
    }];
    
    [dataTask resume];
    [[self tableViewSubjects]reloadData];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subjectsIdArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableViewSubjects dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"Cell"];
    }
    [[cell textLabel] setText:[subjectsDescArray objectAtIndex:[indexPath row]]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dm.subject = [subjectsIdArray objectAtIndex:indexPath.row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"course"]) {
        CourseViewController *vc = (CourseViewController *)segue.destinationViewController;
        vc.subjects = self;
    }
}

@end
