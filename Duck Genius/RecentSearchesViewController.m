//
//  RecentSearchesViewController.m
//  Duck Genius
//
//  Created by Mark Meyer on 2/11/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "RecentSearchesViewController.h"

@interface RecentSearchesViewController ()

@property (strong, nonatomic) NSMutableArray *recentSearches;

@end

@implementation RecentSearchesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Test is RecentSearcher array is in defaults, if not create it
    if (![defaults objectForKey:@"RecentSearches"]) {
        // Initialize the array
        _recentSearches = [[NSMutableArray alloc] init];
    } else {
        // Make a mutable copy of the array so we can update it
        _recentSearches = [[defaults objectForKey:@"RecentSearches"] mutableCopy];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_recentSearches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _recentSearches[indexPath.row];
    
    return cell;
}

- (IBAction)refreshTable:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _recentSearches = [[defaults objectForKey:@"RecentSearches"] mutableCopy];
    [self.tableView reloadData];
    [(UIRefreshControl *)sender endRefreshing];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_recentSearches removeObjectAtIndex:indexPath.row];
        
        [self synchornizeUserDefaults];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id item = _recentSearches[fromIndexPath.row];
    [_recentSearches insertObject:item atIndex:toIndexPath.row];
    [self synchornizeUserDefaults];

}

- (void)synchornizeUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_recentSearches forKey:@"RecentSearches"];
    [defaults synchronize];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

@end
