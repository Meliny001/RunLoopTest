//
//  ViewController.m
//  RunLoopTest
//
//  Created by HYG_IOS on 16/10/17.
//  Copyright © 2016年 magic. All rights reserved.
//

#import "ViewController.h"
#import "ZGThread.h"

@interface ViewController ()

@property(nonatomic,strong) ZGThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.thread = [[ZGThread alloc]initWithTarget:self selector:@selector(threadTest) object:nil];
    [self.thread start];
}

- (void)threadTest
{
    NSLog(@"%@",[NSThread currentThread]);
    // 加入runLoop 线程保活
    [self test1];
}

/// MARK:-有效状态
- (void)test1
{
    // 一个线程对应一个runLoop ,一个runLoop可有多个mode
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    [[NSRunLoop currentRunLoop]run];
    

}
- (void)test2
{
    // 程序允许时默认的Mode
    while (1) {
        [[NSRunLoop currentRunLoop]run];
        NSLog(@"%@",[NSRunLoop currentRunLoop]);
    }
}

/// MARK:-无效状态
- (void)test3
{
    // 主线程runLoop自动开启,子线程需手动开启
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
}

- (void)test4
{
    [[NSRunLoop currentRunLoop]run];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
}

/// MARK:-点击时查看线程
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(touchTest) onThread:self.thread withObject:nil waitUntilDone:NO];
}
- (void)touchTest
{
    NSLog(@"%@",[NSThread currentThread]);
}

@end
