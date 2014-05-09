//
//  SignupView.m
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import "SignupView.h"

@interface SignupView ()

@end

@implementation SignupView

@synthesize usernameEntry, emailEntry, passwordEntry, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Sign Up";
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //enter email, username, password info
    [emailEntry setDelegate:self];
    [usernameEntry setDelegate:self];
    [passwordEntry setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSignup:(id)sender {
    
    NSString *user = [usernameEntry text];
    NSString *pass = [passwordEntry text];
    NSString *email = [emailEntry text];
    
    //checks to make sure user information has at least 4 characters
    if ([user length] < 4 || [pass length] < 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Username and Password must both be at least 5 characters." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if ([email length] < 8) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please enter your email address." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        
        //indicates activity
        [activityIndicator startAnimating];
        
        //Signing up user using Email, username, password. Clicking Sign up takes the user to ListViewController
        PFUser *newUser = [PFUser user];
        newUser.username = user;
        newUser.password = pass;
        newUser.email = email;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [activityIndicator stopAnimating];
            if (error) {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            } else {
                [self performSegueWithIdentifier:@"signupToMain" sender:self];
            }
        }];
    }
    
}

//cancels screen and goes back to Registration
- (void)didTapBack:(id)sender {
    NSLog(@"Go Back to Main");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissKeyboard {
    [usernameEntry resignFirstResponder];
    [passwordEntry resignFirstResponder];
    [emailEntry resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
