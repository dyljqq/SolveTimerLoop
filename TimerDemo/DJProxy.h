//
//  DJProxy.h
//  TimerDemo
//
//  Created by 季勤强 on 2018/6/7.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJProxy : NSProxy

+ (instancetype)proxyWithTarget: (id)target;

@end
