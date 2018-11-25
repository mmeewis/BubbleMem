//
//  MBMReactionScoreView.m
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMReactionScoreView.h"

@implementation MBMReactionScoreView

@synthesize timeValueLabel;
@synthesize titleLabel;
@synthesize bestReactionValueLabel;
@synthesize averageReactionValueLabel;
@synthesize lastReactionValueLabel;

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
    timeValueLabel.text = @"0.0s";
    bestReactionValueLabel.text = @"0.0s";
    averageReactionValueLabel.text = @"0.0s";
    lastReactionValueLabel.text = @"0.0s";
}

- (void) displayScoresForCounter:(MBMCounter *)counter {
    bestReactionValueLabel.text = [NSString stringWithFormat:@"%.1fs", counter.bestReaction];
    averageReactionValueLabel.text = [NSString stringWithFormat:@"%.1fs", counter.averageReaction];
    lastReactionValueLabel.text = [NSString stringWithFormat:@"%.1fs", counter.lastReaction];
}

- (void) displayElapsedTime:(NSTimeInterval)elapsedTime {
    // if (self.isVisble) {
    //    timeValueLabel.text = [NSString stringWithFormat:@"%.1fs", elapsedTime];
    // }

}

@end
