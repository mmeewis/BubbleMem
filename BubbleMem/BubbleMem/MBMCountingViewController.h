//
//  MBMCountingViewController.h
//  BubbleMem
//
//  Created by Marc Meewis on 20/04/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MBM_COUNTERVALUE_VIEW_START_SIZE 25
#define MBM_COUNTERVALUE_VIEW_END_SIZE 100

typedef enum {up, down} MBMCountDirection;


@protocol MBMCountingViewControllerDelegate <NSObject>

- (void) countingAnimationCompleted;

@end

@interface MBMCountingViewController : UIViewController

@property(nonatomic,assign) id <MBMCountingViewControllerDelegate> delegate;

- (void) count:(MBMCountDirection)direction animationDuration:(NSTimeInterval)duration;


@end
