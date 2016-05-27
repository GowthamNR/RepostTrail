//
//  ProfileViewController.m
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    ServiceForRepost *Profile=[[ServiceForRepost alloc]init];
    Profile.delegate=self;
    [Profile getProfileDetails:[[NSUserDefaults standardUserDefaults]valueForKey:@"token"]];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma DelegatesForProfileAPICall

-(void)getProfileSucess:(NSDictionary *)Success
{
   //Delegate Method handling and parsing the response for Profile Details
    
    [[NSUserDefaults standardUserDefaults]setObject:[[Success valueForKey:@"data"]valueForKey:@"id"] forKey:@"UserId"];
  
    self.txtFullName.text=[NSString stringWithFormat:@"%@",[[Success valueForKey:@"data"]valueForKey:@"full_name"]];
  
    //Assigning the Image Url for the Profile ImageView
    NSString *Strurl = [[Success valueForKey:@"data"]valueForKey:@"profile_picture"];
    NSURL *url = [NSURL URLWithString:Strurl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.imgVwProfile.image= [[UIImage alloc] initWithData:data];
  
    self.imgVwProfile.layer.cornerRadius = 50;
  
    self.imgVwProfile.clipsToBounds = YES;
    
    self.txtfollowedBy.text=[NSString stringWithFormat:@"Followers: %@   Following: %@",[[[Success valueForKey:@"data"]valueForKey:@"counts"]valueForKey:@"followed_by"],[[[Success valueForKey:@"data"] valueForKey:@"counts"]valueForKey:@"follows"]];
    
    //Calling Method toGetmedia
    [self performSelector:@selector(ToGetMedia) withObject:self afterDelay:1.00];
}

-(void)getProfileFailure:(NSString *)Error
{
    //Delegate to handling API Failure and error description
        NSLog(@"Failure to get Profile-%@",Error);
}

#pragma Calling MEDIA API call

-(void)ToGetMedia
{
    //Making a call for Instagram GET MEDIA API to get User Media and Token as a Parameter
    
    ServiceForRepost *Profile=[[ServiceForRepost alloc]init];
    Profile.delegate=self;
    [Profile getMedia:[[NSUserDefaults standardUserDefaults]valueForKey:@"token"]];
 
}

#pragma DelegatesForMediaAPICall

-(void)getMediaSuccess:(NSDictionary *)Success
{
    //Handling the GET MEDIA API Response and Parsing the Response For Newsfeed Images and Caption

    self.NextUrl=[[Success valueForKey:@"pagination" ] valueForKey:@"next_url"];
   self.ImageArray=[Success valueForKey:@"data"];
    
    self.ImageURl=[[NSMutableArray alloc]init];
    self.CaptionForImages=[[NSMutableArray alloc]init];
    
    
    for (NSDictionary *temp in self.ImageArray)
    {
        if ([temp valueForKey:@"images"])
        {
            [self.ImageURl addObject:[[[temp valueForKey:@"images"]valueForKey:@"thumbnail"]valueForKey:@"url"]];
            [self.CaptionForImages addObject:[[temp valueForKey:@"caption"] valueForKey:@"text"]];
        }
    }

    //Reloading the collection View
    [self.CollVwPics reloadData];
}
-(void)getMediaFailure:(NSString *)Error
{
    //Handling the GET MEDIA API failure
    NSLog(@"Failure to get Media-%@",Error);
}

-(void)getNewPosts
{
    if (self.NextUrl==nil)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"No more posts" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
    ServiceForRepost *New=[[ServiceForRepost alloc]init];
    New.delegate=self;
    [New getNextMedia:self.NextUrl];
    }
}

-(void)getNextMediaSuccess:(NSDictionary *)Success
{
    self.NextUrl=[[Success valueForKey:@"pagination" ] valueForKey:@"next_url"];
    self.ImageArray=[Success valueForKey:@"data"];
    
    for (NSDictionary *temp in self.ImageArray)
    {
        if ([temp valueForKey:@"images"])
        {
            [self.ImageURl addObject:[[[temp valueForKey:@"images"]valueForKey:@"thumbnail"]valueForKey:@"url"]];
            [self.CaptionForImages addObject:[[temp valueForKey:@"caption"] valueForKey:@"text"]];
        }
    }
    
    //Reloading the collection View
    [self.CollVwPics reloadData];

}

-(void)getNextMediaFailure:(NSString *)Fail
{
    
}
#pragma CollectionViewDelegates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ImageURl.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    PicsViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"pics" forIndexPath:indexPath];
    if (indexPath.row==[self.ImageURl count]-1)
    {
        [self getNewPosts];
    }
    cell.ImgVwPics.layer.borderWidth=2.0f;
    cell.ImgVwPics.layer.borderColor=[UIColor blackColor].CGColor;
    
    [cell.ImgVwPics sd_setImageWithURL:[NSURL URLWithString:self.ImageURl[indexPath.row]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Checking whether the caption for a Image is Null or not
    
    if ([self.CaptionForImages[indexPath.row] isKindOfClass:[NSNull class]])
    {
        UIAlertView *cap=[[UIAlertView alloc]initWithTitle:@"No Caption found for this Post" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [cap show];

    }
    else
    {
        // Alert View Customization for Showing  selected Image
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
       
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.ImageURl[indexPath.row]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        imageView.contentMode=UIViewContentModeCenter;

        NSString *ColRow=[NSString stringWithFormat:@"Column-%ld Row-%ld",(long)indexPath.section+1,(long)indexPath.row];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ColRow
                                                            message:self.CaptionForImages[indexPath.row]                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        
        [alertView setValue:imageView forKey:@"accessoryView"];
        
        [alertView show];

    }
}


#pragma ToSettingsScreen
- (IBAction)barBtnsettings:(id)sender
{
    //Pushing to settings Screen
          [self performSegueWithIdentifier:@"Settings" sender:self];
}


@end
