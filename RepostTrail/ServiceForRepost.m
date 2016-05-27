//
//  ServiceForRepost.m
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import "ServiceForRepost.h"

@implementation ServiceForRepost

-(void)getProfileDetails:(NSString *)token

{
    //API call for getting UserProfiles From Instagram API with token as parameter

    NSString *Url =[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self?access_token=%@",token];
   
    // Using AFNetworking for WebCall
    
    AFHTTPSessionManager *manager =
    [AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [manager GET:Url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSError *error=nil;
         
         NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         
         //Delegates To handle User Profile successful API call
         
        [self.delegate getProfileSucess:dict];
     }
          failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         //Delegates To handle User Profile Failure API Call
         
         [self.delegate getProfileFailure:[error localizedDescription]];
         
     }];
}

-(void)getMedia:(NSString *)token
{
    //API call for getting User Media From Instagram API with token as parameter
  
    NSString *Url =[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed?access_token=%@",token];

    // Using AFNetworking for WebCall
    
    AFHTTPSessionManager *manager =
    [AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:Url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSError *error=nil;
         
         NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         
         //Delegates To handle User Media successful API call
         
         [self.delegate getMediaSuccess:dict];
     }
     
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         //Delegates To handle User Media Failure API Call
         
         [self.delegate getMediaFailure:[error localizedDescription]];
         
     }];
}
-(void)getNextMedia:(NSString *)NextUrl
{
    NSLog(@"%@",NextUrl);
    
    NSString *Url =NextUrl;
    
    // Using AFNetworking for WebCall
    
    AFHTTPSessionManager *manager =
    [AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:Url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSError *error=nil;
         
         NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         
         //Delegates To handle User Media successful API call
         
         [self.delegate getNextMediaSuccess:dict];
     }
     
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         //Delegates To handle User Media Failure API Call
         
         [self.delegate getNextMediaFailure:[error localizedDescription]];
         
     }];
 
}
@end
