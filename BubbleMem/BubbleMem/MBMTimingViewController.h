//
//  MBMTimingViewController.h
//  BubbleMem
//
//  Created by Marc Meewis on 12/04/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMTimingView.h"

@interface MBMTimingViewController : UIViewController

@property NSTimeInterval maxTime;
@property NSTimeInterval referenceTime;
@property UIColor *equalOrLessThenReferenceTimeColor;
@property UIColor *greaterThenReferenceTimeColor;
@property UIColor *exceededMaxTimeColor;
@property UIColor *referenceTimeColor;

- (void) fillWithColor:(UIColor *)color;
- (void) animateTiming;

- (void) resetTiming;
- (void) initTimingWithReferenceTime:(NSTimeInterval)time andMaxTime:(NSTimeInterval)mxTime;
- (void) updateTiming:(NSTimeInterval)time;

@end
