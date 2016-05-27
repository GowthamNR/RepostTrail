//
//  ViewController.h
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import <UIKit/UIKit.h>
//Constants obtained from Instagram after registering the Applictaion 
#define kBaseURL @"https://instagram.com/"
#define kInstagramAPIBaseURL @"https://api.instagram.com"
#define kAuthenticationURL @"oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=likes+comments+basic"
#define kClientID @"19a32e0e2a0e4c29afb02a97fe41a0f7"
#define kRedirectURI @"http://www.bifortis.com"



@interface ViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *InstagramWebVw;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *webVeLoading;


@end

