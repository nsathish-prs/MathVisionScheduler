//
//  LoginViewController.h
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>

@interface LoginViewController : UIViewController <GPPSignInDelegate>


- (IBAction)SignInGoogle:(id)sender;

@end
