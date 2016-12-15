//
//  ViewController.m
//  LikeButton
//
//  Created by 天利合 on 2016/12/15.
//  Copyright © 2016年 天利合. All rights reserved.
//

#import "ViewController.h"
#import "LikeButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LikeButton * button = [LikeButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 24, 24);
    [button setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.animationType = ButtonAnimationTypeScale;
    [self.view addSubview:button];
}
- (void)buttonClick:(UIButton *)sender {
    sender.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
