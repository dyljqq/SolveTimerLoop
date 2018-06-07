//
//  TimerViewController.m
//  TimerDemo
//
//  Created by 季勤强 on 2018/6/7.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

#import "TimerViewController.h"
#import "DJProxy.h"

@interface TimerViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TimerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor blueColor];
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:[DJProxy proxyWithTarget:self] selector:@selector(timerAction) userInfo:nil repeats:YES];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  button.backgroundColor = [UIColor redColor];
  [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
//  if (_timer.isValid) {
//    [_timer invalidate];
//    _timer = nil;
//  }
}

- (void)timerAction {
  NSLog(@"timer action...");
}

- (void)closeAction {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
  NSLog(@"dealloc");
  if (_timer.isValid) {
    [_timer invalidate];
    _timer = nil;
  }
}

@end
