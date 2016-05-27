//
//  settingsViewController.m
//  RepostTrail
//
//  Created by Bifortis on 7/27/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()

@end

@implementation settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    //Initializing the Array for TableView options
    
    self.feedTosettings=@[@"Unlock Pro"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.feedTosettings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Unlock"];
   
    cell.textLabel.text=[NSString stringWithFormat:@"%@",self.feedTosettings[indexPath.row]];
    
    return cell;
}

- (IBAction)ButtonDone:(id)sender
{
    //Dismissing the Settings table options screen
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
