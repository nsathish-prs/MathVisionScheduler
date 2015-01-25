//
//  DataModel.h
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject{
    NSString *kClientId;
    NSString *URL;
    NSString *course;
    NSString *subject;
    NSString *topic;
}

@property(strong,nonatomic) NSString *kClientId;
@property(strong,nonatomic) NSString *URL;
@property (strong, nonatomic) NSString *course;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *topic;

@end
