//
//  MBMTotalsScoreView.m
//  BubbleMem
//
//  Created by Marc Meewis on 23/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMGamesScoreView.h"

@implementation MBMGamesScoreView

@synthesize cancelledValueLabel;
@synthesize completedValueLabel;
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
    cancelledValueLabel.text = @"0";
    completedValueLabel.text = @"0";
    timeValueLabel.text = @"0.0s";
}

- (void) displayScoresForCounter:(MBMCounter *)counter {    
    cancelledValueLabel.text = [NSString stringWithFormat:@"%d", counter.cancelled];
    completedValueLabel.text = [NSString stringWithFormat:@"%d", counter.completed];
    
}

- (void) displayElapsedTime:(NSTimeInterval)elapsedTime {
    // if (self.isVisble) {
    //    timeValueLabel.text = [NSString stringWithFormat:@"%.1fs", elapsedTime];
    // }
}

@end
