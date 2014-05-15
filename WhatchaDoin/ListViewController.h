//
//  ListViewController.h
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import <Parse/Parse.h>

@interface ListViewController : PFQueryTableViewController

{
    //IBOutlet UIBarButtonItem *toggleEdit;
    NSString *List;
    NSDictionary *params;
    NSInteger counter;
    NSInteger refreshData;
}

- (IBAction)logoutBttn :(id)sender;
//-(IBAction)toggleEdit:(id)sender;

//Network connection status
@property (assign, nonatomic) IBOutlet UILabel * networkConnection;
@property (assign, nonatomic) IBOutlet UILabel * networkStatus;

@end
