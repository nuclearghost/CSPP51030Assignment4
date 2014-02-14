//
//  SearchViewController.m
//  Duck Genius
//
//  Created by Mark Meyer on 2/11/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    self.clearsSelectionOnViewWillAppear = NO;
 
    [self downloadData:@"Chicago"];
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
    NSMutableArray *arr = [self.searchResults objectForKey:@"RelatedTopics"];
    return arr ? arr.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchCell";
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *arr = [self.searchResults objectForKey:@"RelatedTopics"];
    NSDictionary *dict = [arr objectAtIndex:indexPath.row];
    cell.text.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Text"]];
    cell.label.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"FirstURL"]];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchCell *cell = (SearchCell*)sender;
    
    WebViewController *wvc = (WebViewController*)segue.destinationViewController;
    wvc.url = cell.label.text;
}

- (IBAction)addButtonTapped:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Query" message:@"Enter search term" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    NSLog(@"alerttextfiled - %@",alertTextField.text);
    // Pass this text to our download method
    if ([alertTextField.text length] != 0){
        [self downloadData:alertTextField.text];
    }
}

- (void)downloadData:(NSString*)queryTerm
{
    NSString *query = [NSString stringWithFormat:@"http://api.duckduckgo.com/?q=%@&format=json&pretty=1",queryTerm];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:query]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                NSError *errorJson = nil;
                // Convert JSON to NSDictionary
                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
                
                // Update the searchResults property
                self.searchResults = [results mutableCopy];
                
                // Refresh the table on main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
            }] resume];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Test is RecentSearcher array is in defaults, if not create it
    NSMutableArray *recentSearches;
    if (![defaults objectForKey:@"RecentSearches"]) {
        // Initialize the array
        recentSearches = [[NSMutableArray alloc] init];
    } else {
        // Make a mutable copy of the array so we can update it
        recentSearches = [[defaults objectForKey:@"RecentSearches"] mutableCopy];
    }
    // Add the term to local array
    [recentSearches addObject:queryTerm];
    // Copy local array to user defaults
    [defaults setObject:recentSearches forKey:@"RecentSearches"];
    // Write it to disk
    [defaults synchronize];
    // Call dictionaryRepresentation on default to display readable output
    NSLog(@"Defaults:%@",[defaults dictionaryRepresentation]);
}
@end
