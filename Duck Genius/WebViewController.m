//
//  WebViewController.m
//  Duck Genius
//
//  Created by Mark Meyer on 2/11/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     NSURLRequest *request =
        [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)refreshTapped:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (IBAction)backTapped:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)forwardTapped:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
@end
