//
//  TaskViewController.h
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *item;
- (IBAction)addItem:(id)sender;

@end
