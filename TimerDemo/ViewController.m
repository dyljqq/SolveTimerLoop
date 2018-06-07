//
//  ViewController.m
//  TimerDemo
//
//  Created by 季勤强 on 2018/6/7.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  button.backgroundColor = [UIColor redColor];
  [button setTitle:@"点我点我" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(openAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)openAction {
  UIViewController *vc = [[TimerViewController alloc] init];
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
