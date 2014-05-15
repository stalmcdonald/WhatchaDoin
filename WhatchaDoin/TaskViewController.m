//
//  TaskViewController.m
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import "TaskViewController.h"
#import "Reachability.h"

@interface TaskViewController ()

-(void)reachabilityChanged:(NSNotification*)note;

@end

@implementation TaskViewController
@synthesize item, networkConnection, networkStatus;

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
    [item becomeFirstResponder];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            networkConnection.text = @"Create a new task, Stay on Task";
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            networkConnection.text = @"Network Status: OFFLINE";
        });
    };
    
    [reach startNotifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//checks network status
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        networkStatus.text = @"Boost Productivity";
    }
    else
    {
        networkStatus.text = @"Offline features limited";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning." message:@"Check internet connection. User input restricted." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
//        [alert show];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == item)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else
        return YES;
}

- (IBAction)addItem:(id)sender {
    
    NSString *taskEntered = [item text];
    
    //validation length checker
    if([taskEntered length] < 2 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unacceptable Task" message:@"Task entered must be at least 2 characters." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    
    }else{
        
    //saves tasks to task list in TaskViewController and gives a confirmation
    PFObject *task = [PFObject objectWithClassName:@"taskList"];
    [task setObject:item.text forKey:@"item"];
    
    [task saveInBackground];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhatchaDoin"
                                                    message:@"Task added to task management list."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    item.text=@"";
    
}
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end