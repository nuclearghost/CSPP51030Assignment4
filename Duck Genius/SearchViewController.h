//
//  SearchViewController.h
//  Duck Genius
//
//  Created by Mark Meyer on 2/11/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController
- (IBAction)addButtonTapped:(id)sender;

@property (strong,nonatomic) NSMutableDictionary *searchResults;

@end
