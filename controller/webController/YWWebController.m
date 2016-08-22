//
//  YWWebController.m
//  YQSearch
//
//  Created by liyunqi on 8/22/16.
//  Copyright © 2016 yunqi. All rights reserved.
//

#import "YWWebController.h"
@interface YWWebController()
{
    
}
PROPERTY_STRONG UIWebView* showWebView;
@end
@implementation YWWebController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showWebView = [[UIWebView alloc] init];
    //    self.showWebView.delegate = self;
    self.showWebView.backgroundColor = [UIColor clearColor];
    self.showWebView.frame = CGRectMake(0, 64,
                                        CGRectGetWidth(self.view.frame),
                                        CGRectGetHeight(self.view.frame) - 64);
    self.showWebView.scalesPageToFit = YES;
    [self.view addSubview:self.showWebView];
    [self loadUrl:_urlString];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)loadUrl:(NSString*)urlPath
{
    NSURL* url = [NSURL URLWithString:[urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* requeseUrl = [NSMutableURLRequest requestWithURL:url];
    [self.showWebView loadRequest:requeseUrl];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

@end
