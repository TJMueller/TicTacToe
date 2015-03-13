//
//  HelpViewController.m
//  TicTacToe
//
//  Created by Timothy Mueller on 3/13/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self goToURLString:@"http://www.mobilemakers.co"];
    self.webView.delegate = self;
}
- (void)goToURLString:(NSString *)string {
    NSString *urlString = string;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}


@end
