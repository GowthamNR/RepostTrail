//
//  ViewController.m
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [self.webVeLoading startAnimating];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
     //Initializing Instagram Application for User Login
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
    
// Loading the webView with Instagram URL for User login
        NSString* urlString = [kBaseURL stringByAppendingFormat:kAuthenticationURL,kClientID,kRedirectURI];
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [self.InstagramWebVw loadRequest:request];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    //Parsing the Response for the access token after Instagram login
   
    self.webVeLoading.hidden=YES;
    
    NSString* urlString = [[request URL] absoluteString];
    
    NSArray *UrlParts = [urlString componentsSeparatedByString:[NSString stringWithFormat:@"%@/", kRedirectURI]];
   
    if ([UrlParts count] > 1)
    {
    
        urlString = [UrlParts objectAtIndex:1];
      
        NSRange accessToken = [urlString rangeOfString: @"#access_token="];
        
        if (accessToken.location != NSNotFound)
        {
            [[NSUserDefaults standardUserDefaults]setObject: [urlString substringFromIndex: NSMaxRange(accessToken)] forKey:@"token"];

         //Pushing it to Profile Screen after saving User AccessToken
            
        [self performSegueWithIdentifier:@"ToProfile" sender:self];
        }
        return NO;
    }
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
}
@end
