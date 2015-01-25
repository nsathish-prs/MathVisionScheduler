//
//  LoginViewController.m
//  MathVision_Scheduler
//
//  Created by Math Vision on 11/1/15.
//  Copyright (c) 2015 Math Vision. All rights reserved.
//

#import "LoginViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "DataModel.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

DataModel *dm;
GPPSignIn *signIn;


@synthesize spinner;


- (void)viewDidLoad {
    [super viewDidLoad];
    [spinner startAnimating];
    signIn = [GPPSignIn sharedInstance];
    signIn.clientID =dm.kClientId;
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.scopes = @[ @"profile" ];
    signIn.delegate = self;
    [signIn trySilentAuthentication];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
//    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (!error) {
    [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }
    [spinner stopAnimating];
}

- (void)didDisconnectWithError:(NSError *)error{
    [spinner stopAnimating];
//    NSLog(@"%@",error);
}
- (IBAction)SignInGoogle:(id)sender {
    [spinner startAnimating];
    [signIn authenticate];
}
@end
