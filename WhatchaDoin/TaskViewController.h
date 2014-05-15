//
//  TaskViewController.h
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface TaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *item;
- (IBAction)addItem:(id)sender;


//Network connection status
@property (assign, nonatomic) IBOutlet UILabel * networkConnection;
@property (assign, nonatomic) IBOutlet UILabel * networkStatus;

@end
