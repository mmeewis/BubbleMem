//
//  MBMTotalsScoreView.m
//  BubbleMem
//
//  Created by Marc Meewis on 23/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMTimingsScoreView.h"

@implementation MBMTimingsScoreView

@synthesize bestTimeValueLabel;
@synthesize averageTimeValueLabel;
@synthesize timeValueLabel;
@synthesize titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) initValues {
    bestTimeValueLabel.text = @"0.0s";
    averageTimeValueLabel.text = @"0.0s";
    timeValueLabel.text = @"0.0s";
}

- (void) displayScoresForCounter:(MBMCounter *)counter {    
    bestTimeValueLabel.text = [NSString stringWithFormat:@"%.1fs", counter.bestTime];
    averageTimeValueLabel.text = [NSString stringWithFormat:@"%.1fs", counter.averageTime];
    
}

- (void) displayElapsedTime:(NSTimeInterval)elapsedTime {
    // if (self.isVisble) {
    //    timeValueLabel.text = [NSString stringWithFormat:@"%.1fs", elapsedTime];
    // }
}

// Is the scrollview page the view is on visible?



@end
