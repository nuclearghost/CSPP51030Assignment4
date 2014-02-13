//
//  WebViewController.h
//  Duck Genius
//
//  Created by Mark Meyer on 2/11/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSString *url;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)refreshTapped:(id)sender;
- (IBAction)backTapped:(id)sender;
- (IBAction)forwardTapped:(id)sender;

@end
