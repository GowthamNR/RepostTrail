//
//  ProfileViewController.h
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceForRepost.h"
#import "UIImageView+WebCache.h"
#import "PicsViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController : UIViewController<ServiceRepost,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIImageView *imgVwProfile;
@property (strong, nonatomic) IBOutlet UILabel *txtFullName;
@property (strong, nonatomic) IBOutlet UILabel *txtfollowedBy;
@property (strong,nonatomic) NSArray *ImageArray;
@property (strong,nonatomic) NSMutableArray *ImageURl;
@property (strong,nonatomic)NSMutableArray *CaptionForImages;
@property (strong,nonatomic)NSString *NextUrl;
@property (strong, nonatomic) IBOutlet UICollectionView *CollVwPics;
@end
