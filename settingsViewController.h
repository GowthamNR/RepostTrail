//
//  settingsViewController.h
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *SettingTabVw;
@property (strong,nonatomic) NSArray *feedTosettings;
@end
