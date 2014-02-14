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
    
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Reset.png"] style:UIBarButtonItemStylePlain target:self action:@selector(refreshTapped:)];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Previous.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    UIBarButtonItem *forwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Next.png"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardTapped:)];
    
    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.leftBarButtonItem = refreshBtn;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:forwardBtn, backBtn, nil];
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
