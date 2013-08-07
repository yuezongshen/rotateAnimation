//
//  abcViewController.m
//  rotateAnimationDemo
//
//  Created by 岳宗申 on 13-8-7.
//  Copyright (c) 2013年 岳宗申. All rights reserved.
//

#import "abcViewController.h"

@interface abcViewController ()
{
    NSTimer *timer;
    int theta;
    CGFloat a;
    int k ;
}
@end

@implementation abcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    timer = nil;
    theta = 1;
    k = 0;
}
- (void)startAction:(UIButton *)sender
{
    if (!timer) {
        k++;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"BFlyCircle%d.png",k]]];
        imgView.tag = 1000+k;
        imgView.center = CGPointMake(860, 143);
        [self.view addSubview:imgView];
        [imgView release];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(move:) userInfo:nil repeats:YES];
    }
}
- (void)move:(NSTimer *)aTimer
{
    CGFloat angle = theta * (M_PI / 100.0f);
    CGAffineTransform transform = CGAffineTransformMakeRotation(-angle);
    theta = theta %(200);// 0~2PI
     a = angle - a;
    
    UIImage *image = [UIImage imageNamed:@"BFlyCircle"];
    float w = image.size.width;
    float longe =  w*M_PI;
    float rrr = a/M_PI/2*longe;
    
//    CGAffineTransform newtan = CGAffineTransformTranslate(transform,-rrr/20,0);
    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:1000+k];
    [imgView setTransform:transform];
    NSLog(@"kdkfsdfsdf = %f",imgView.center.x);
    NSLog(@"rrrr = %f",rrr);
    imgView.center = CGPointMake(imgView.center.x-rrr, imgView.center.y);
    a = angle;
    if (k ==1) {
        if (theta == 0) {
            [timer invalidate];
            timer = nil;
            theta = 1;
            a = 0.0;
            [self startAction:nil];
            NSLog(@"center = %f",imgView.center.x);
        }

    }
    else
    {
        UIImageView *imageV = (UIImageView *)[self.view viewWithTag:1000+k-1];
        NSLog(@"图片的宽度是：%f",image.size.width);
        NSLog(@"当k = 2的时候前一张图片的中心是:%f",imageV.center.x);
         NSLog(@"本张图片的中心是:%f",imgView.center.x);
        NSLog(@"相差多少%f",imgView.center.x-imageV.center.x);
        if (imgView.center.x-imageV.center.x <= image.size.width) {
            [timer invalidate];
            timer = nil;
            theta = 1;
            a = 0.0f;
            [self startAction:nil];
        }
    }
    if ( k == 5) {
        [timer invalidate];
        timer = nil;
    }
    theta++;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
