//
//  ListViewController.m
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

@synthesize networkConnection, networkStatus;

-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithClassName:@"taskList"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"taskList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"item";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // PUll down to refresh cells
        self.pullToRefreshEnabled = YES;
        
        // Pagination disabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    List = @"<html><body>";
    refreshData =0;
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    counter =[query countObjects];
    NSLog(@"%d",counter);
    
    
    
    // If no objects are loaded in memory, goes to cache first to fill the table
    // and then does a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    
    return query;
    
}



// customizing cell so it doesnt start with the first key in object but the last
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"item"];
    
    
    
    //Create the list
    if(refreshData <counter)
    {
        NSString *br = @"<br>";
        List = [NSString stringWithFormat:@"%@%@%@", List, br, cell.textLabel.text];
        NSLog(@"%@",List);
        refreshData ++;
    }
    
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

-(IBAction)logoutBttn:(id)sender {
    
    [PFUser logOut];;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//
//
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//
//}


@end
