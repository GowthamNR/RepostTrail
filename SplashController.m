//
//  SplashController.m
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import "SplashController.h"

@interface SplashController ()

@end

@implementation SplashController

- (void)viewDidLoad {
    
    
    //splash animation Screen
    [UIView animateWithDuration:2.0 animations:^
    {
        self.imgVwsplash.alpha = 1.0;
                self.imgVwsplash.transform =CGAffineTransformMakeScale(1.1,1.1);
        
        // calling ToWebView method after animation
        [self performSelector:@selector(ToWebView) withObject:self afterDelay:5];
        
    }];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)ToWebView
{
    //Pushing to  Instagram Login
    [self performSegueWithIdentifier:@"ToWebView" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
