//
//  DJProxy.m
//  TimerDemo
//
//  Created by 季勤强 on 2018/6/7.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

#import "DJProxy.h"

@interface DJProxy()

@property (nonatomic, weak) id target;

@end

@implementation DJProxy

- (instancetype)initWithTarget: (id)target {
  self.target = target;
  return self;
}

+ (instancetype)proxyWithTarget: (id)target {
  return [[DJProxy alloc] initWithTarget:target];
}

- (id)forwardingTargetForSelector {
  return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
  [invocation invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
  return [self.target methodSignatureForSelector:selector];
}

@end
