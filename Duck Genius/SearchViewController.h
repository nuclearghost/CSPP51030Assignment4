//
//  SearchViewController.h
//  Duck Genius
//
//  Created by Mark Meyer on 2/11/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCell.h"
#import "WebViewController.h"

@interface SearchViewController : UITableViewController

@property (strong,nonatomic) NSMutableDictionary *searchResults;

- (IBAction)addButtonTapped:(id)sender;
- (void)downloadData:(NSString*)queryTerm andStoreInUserDefaults:(BOOL)flag;

@end
