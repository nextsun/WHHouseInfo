//
//  FirstViewController.m
//  WHHouseInfo
//
//  Created by Lei Sun on 3/30/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "FirstViewController.h"
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"


@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic,strong)ASIWebPageRequest* request;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    http://scxx.whfcj.gov.cn/scxxbackstage/whfcj/contents/854/21890.html
    //    http://scxx.whfcj.gov.cn/scxxbackstage/whfcj/contents/854/23981.html
    
//    NSString* url =  @"http://scxx.whfcj.gov.cn/scxxbackstage/whfcj/contents/854/23981.html";
    
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"htm" inDirectory:@"html5"];
    
    
    self.webView.scrollView.bounces = NO;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
//    [self loadURL:[NSURL fileURLWithPath:htmlPath]];

}

- (IBAction)loadURL:(NSURL *)url
{
    // Assume request is a property of our controller
    // First, we'll cancel any in-progress page load
    [[self request] setDelegate:nil];
    [[self request] cancel];
    
    [self setRequest:[ASIWebPageRequest requestWithURL:url]];
    [[self request] setDelegate:self];
    [[self request] setDidFailSelector:@selector(webPageFetchFailed:)];
    [[self request] setDidFinishSelector:@selector(webPageFetchSucceeded:)];
    
    // Tell the request to embed external resources directly in the page
    [[self request] setUrlReplacementMode:ASIReplaceExternalResourcesWithData];
    
    // It is strongly recommended you use a download cache with ASIWebPageRequest
    // When using a cache, external resources are automatically stored in the cache
    // and can be pulled from the cache on subsequent page loads
    [[self request] setDownloadCache:[ASIDownloadCache sharedCache]];
    
    // Ask the download cache for a place to store the cached data
    // This is the most efficient way for an ASIWebPageRequest to store a web page
    [[self request] setDownloadDestinationPath:
     [[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:[self request]]];
    
    [[self request] startAsynchronous];
}


- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
{
    // Obviously you should handle the error properly...
    NSLog(@"%@",[theRequest error]);
}

- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
{
//    NSString *response = [NSString stringWithContentsOfFile:
//                          [theRequest downloadDestinationPath] encoding:[theRequest responseEncoding] error:nil];

    NSString *response = [NSString stringWithContentsOfFile:
                          [theRequest downloadDestinationPath] encoding:NSUTF8StringEncoding error:nil];
    // Note we're setting the baseURL to the url of the page we downloaded. This is important!
    [self.webView loadHTMLString:response baseURL:[self.request url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
