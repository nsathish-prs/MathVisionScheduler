//
//  OptionsViewController.m
//  MathVision_Scheduler
//
//  Created by Math Vision on 25/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import "OptionsViewController.h"
#import "DataModel.h"

@interface OptionsViewController (){
    NSMutableArray *optionsIdArray;
    NSMutableArray *optionsDescArray;
    NSMutableArray *optionResults;
}

@end

@implementation OptionsViewController
DataModel *dm;

- (void)viewDidLoad {
    [super viewDidLoad];
    optionsDescArray = [[NSMutableArray alloc]init];
    optionsIdArray = [[NSMutableArray alloc]init];
    [self loadOptions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void) loadOptions {
    NSURLSession *session = [NSURLSession sharedSession];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@/GetSubjects/%@/%@",dm.URL,courseID,gradeID]);
    [optionsIdArray removeAllObjects];
    [optionsDescArray removeAllObjects];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GetOptions",dm.URL]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        optionResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", optionResults);
        for (NSDictionary *item in optionResults) {
            [optionsIdArray  addObject:[item objectForKey:@"OptionId"]];
            [optionsDescArray addObject:[item objectForKey:@"Description"]];
        }
        NSLog(@"%@",optionsIdArray);
        [self.tableView performSelectorOnMainThread:@selector(reloadData)  withObject:nil waitUntilDone:YES];
    }];
    
    [dataTask resume];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [optionsIdArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"Cell"];
    }
    [[cell textLabel] setText:[optionsDescArray objectAtIndex:[indexPath row]]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//     = [optionsIdArray objectAtIndex:indexPath.row];
}


- (IBAction)submitOption:(id)sender {
}
@end
