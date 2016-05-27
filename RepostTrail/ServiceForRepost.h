//
//  ServiceForRepost.h
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol ServiceRepost <NSObject>

@optional

//Delegates for Instagram Profile API
-(void)getProfileSucess:(NSDictionary *)Success;
-(void)getProfileFailure:(NSString *)Error;

//Delegates For Instargram User Media API
-(void)getMediaSuccess:(NSDictionary *)Success;
-(void)getMediaFailure:(NSString *)Error;


-(void)getNextMediaSuccess:(NSDictionary *)Success;
-(void)getNextMediaFailure:(NSString *)Fail;

@end






@interface ServiceForRepost : NSObject

//Declarations of used functions
-(void)getProfileDetails:(NSString *)token;
-(void)getMedia:(NSString *)token;
-(void)getNextMedia:(NSString *)NextUrl;
//Registering the delegate
@property(nonatomic,weak)id<ServiceRepost>delegate;

@end
