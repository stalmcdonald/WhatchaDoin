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
    NSString *List;
    NSDictionary *params;
    NSInteger counter;
    NSInteger refreshData;
}

- (IBAction)logoutBttn :(id)sender;

//Network connection status
@property (assign, nonatomic) IBOutlet UILabel * networkConnection;
@property (assign, nonatomic) IBOutlet UILabel * networkStatus;

@end
