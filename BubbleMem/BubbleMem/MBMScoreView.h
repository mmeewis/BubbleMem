//
//  MBMScoreView.h
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMCounter.h"

@interface MBMScoreView : UIView

@property int positionInScrollView;

- (void) initValues;
- (void) displayScoresForCounter:(MBMCounter *)counter;
- (void) displayElapsedTime:(NSTimeInterval)elapsedTime;
- (BOOL) isVisble;

@end
