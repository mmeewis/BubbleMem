//
//  MBMTimingViewController.m
//  BubbleMem
//
//  Created by Marc Meewis on 12/04/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMTimingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MBMTimingViewController ()

@end

@implementation MBMTimingViewController {
    NSTimeInterval previousTime;
    CGRect fromRect;
    UIView *eolView, *gtView, *exView, *referenceView; // equal or less then = eol, greater then = gt, exceeded = ex;
}

@synthesize maxTime;
@synthesize referenceTime;
@synthesize equalOrLessThenReferenceTimeColor;
@synthesize greaterThenReferenceTimeColor;
@synthesize exceededMaxTimeColor;
@synthesize referenceTimeColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self defaultTimingColors];
    }
    return self;
}

- (void)defaultTimingColors {
    if (equalOrLessThenReferenceTimeColor == nil) {
        equalOrLessThenReferenceTimeColor = [UIColor greenColor];
    }
    if (greaterThenReferenceTimeColor == nil) {
        greaterThenReferenceTimeColor = [UIColor orangeColor];
    }
    if (exceededMaxTimeColor == nil) {
        exceededMaxTimeColor = [UIColor redColor];
    }
    if (referenceTimeColor == nil) {
        referenceTimeColor = [UIColor colorWithRed:217.0/255.0f green:228/255.0f blue:231/255.0f alpha:1.0];
    }
}

- (void) addTimeSubViewsWithReferenceTime:(NSTimeInterval)refTime {
    
    CGRect initRect = CGRectMake(0.0,0.0, 0.0, self.view.superview.frame.size.height);
    
    eolView = [[UIView alloc] initWithFrame:initRect];
    eolView.layer.zPosition = 100;
    [self.view addSubview:eolView];
    eolView.backgroundColor = equalOrLessThenReferenceTimeColor;
    eolView.hidden = NO;
    
    referenceView = [[UIView alloc] initWithFrame:[self rectangleForTime:refTime]];
    eolView.layer.zPosition = 99;
    [self.view addSubview:referenceView];
    referenceView.backgroundColor = referenceTimeColor;

    gtView  = [[UIView alloc] initWithFrame:initRect];
    gtView.layer.zPosition = 90;
    [self.view addSubview:gtView];
    gtView.backgroundColor = greaterThenReferenceTimeColor;
    gtView.hidden = YES;

    
    exView  = [[UIView alloc] initWithFrame:initRect];
    exView.layer.zPosition = 80;
    [self.view addSubview:exView];
    exView.backgroundColor = exceededMaxTimeColor;
    exView.hidden = YES;

    
}

- (void) removeTimeSubViews {
    
    if (eolView != nil) [eolView removeFromSuperview];
    if (gtView != nil) [gtView removeFromSuperview];
    if (exView != nil) [exView removeFromSuperview];
    if (referenceView != nil) [referenceView removeFromSuperview];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Width %f  , Height %f", self.view.frame.size.width, self.view.frame.size.height);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillWithColor:(UIColor *)color {
    NSLog(@"Width %f  , Height %f", self.view.frame.size.width, self.view.frame.size.height);
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = color;
}

- (void) animateTiming {
    
    CGRect startFrame = CGRectMake(0,0,0, self.view.frame.size.height);
    CGRect toFrame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = startFrame;
    
    [UIView animateWithDuration:4.0 animations:^{
        self.view.frame = toFrame;
    } completion: ^(BOOL finished) {
        
    }];
    
    
}

- (void) resetTiming {
    self.view.backgroundColor = [UIColor clearColor];
    previousTime = 0;
    fromRect = CGRectMake(0.0, 0.0, 0.0, self.view.superview.frame.size.height);
    
    [self removeTimeSubViews];
    
    
}

- (void) initTimingWithReferenceTime:(NSTimeInterval)time andMaxTime:(NSTimeInterval)mxTime {
    maxTime = mxTime;
    referenceTime = time;
    [self addTimeSubViewsWithReferenceTime:time];
}

- (CGRect) rectangleForTime:(NSTimeInterval)time {
    
    float width = (time - previousTime) * ( self.view.superview.frame.size.width / maxTime);
    
    NSLog(@"fromRect.width: %f, calculated width: %f, sum: %f, superview.width: %f ", fromRect.size.width, width, fromRect.size.width + width, self.view.superview.frame.size.width);
    CGRect rect = CGRectMake(0.0, 0.0, fromRect.size.width + width, self.view.superview.frame.size.height);
    
    return rect;
}

- (void) updateTiming:(NSTimeInterval)time {
    
    // The timingView takes the same size as the view it is added to (superview)
    
    NSLog(@"MaxTime %.10f, time %.10f, reference time: %f", maxTime, time, referenceTime);
    
    // float width = (time - previousTime) * ( self.view.superview.frame.size.width / maxTime);
    // NSLog(@"fromRect.width: %f, calculated width: %f, sum: %f, superview.width: %f ", fromRect.size.width, width, fromRect.size.width + width, self.view.superview.frame.size.width);
    // CGRect toRect = CGRectMake(0.0, 0.0, fromRect.size.width + width, self.view.superview.frame.size.height);
    
    CGRect toRect = [self rectangleForTime:time];
    
    
    // UIView *animatedView;
    
    if (time <= referenceTime) {
        // animatedView = eolView;
        gtView.frame = toRect;
        exView.frame = toRect;
        
        [UIView animateWithDuration:(time-previousTime) animations:^{
            eolView.frame = toRect;
        } completion: ^(BOOL finished) {
        }];
    }
    else if ((time > referenceTime) && (time <= (maxTime + 0.00000001))) {
        // animatedView = gtView;
        gtView.hidden = NO;
        // exView.frame = toRect;
        
        NSLog(@"if ((time > referenceTime) && (time <= maxTime))");
        
        [UIView animateWithDuration:(time-previousTime) animations:^{
            gtView.frame = toRect;
        } completion: ^(BOOL finished) {
        }];
    }
    else {
        NSLog(@"else, do nothing");
        // exView.hidden = NO;
        // animatedView = exView;
        
        // do nothing target time is full
        
    }
    
    
    
    // self.view.frame = toRect;
    
    previousTime = time;
    fromRect = toRect;
    
}

@end
