//
//  TopicsViewController.m
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import "TopicsViewController.h"
#import "DataModel.h"

@interface TopicsViewController (){
    NSMutableArray *topicsArray;
    NSMutableArray *topicResults;
}

@end

@implementation TopicsViewController
DataModel *dm;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSession *session = [NSURLSession sharedSession];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@/GetSubjects/%@/%@",dm.URL,courseID,gradeID]);
    topicsArray = [[NSMutableArray alloc]init];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GetTopics/%@",dm.URL,dm.subject]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        topicResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", topicResults);
        [topicsArray removeAllObjects];
        for (NSDictionary *item in topicResults) {
            [topicsArray  addObject:[item objectForKey:@"Description"]];
        }
        NSLog(@"%@",topicsArray);
        [self.tableView performSelectorOnMainThread:@selector(reloadData)  withObject:nil waitUntilDone:YES];
    }];
    
    [dataTask resume];
    [self.tableView reloadData];

}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topicsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"Cell"];
    }
    [[cell textLabel] setText:[topicsArray objectAtIndex:[indexPath row]]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
