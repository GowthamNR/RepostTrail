//
//  InstructionsController.m
//  RepostTrail
//
//  Created by Bifortis on 7/31/15.
//  Copyright (c) 2015 Bifortis. All rights reserved.
//

#import "InstructionsController.h"

@interface InstructionsController ()

@end

@implementation InstructionsController

- (void)viewDidLoad {
    
    
    self.insTxtVw.layer.borderWidth=2.0f;
    
    self.insTxtVw.layer.borderColor=[UIColor darkGrayColor].CGColor;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
