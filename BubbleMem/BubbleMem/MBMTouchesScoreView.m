//
//  MBMTouchesScoreView.m
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMTouchesScoreView.h"

@implementation MBMTouchesScoreView

@synthesize titleLabel;
@synthesize timeValueLabel;
@synthesize hitsValueLabel;
@synthesize missesValueLabel;
@synthesize orderedValueLabel;

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
    hitsValueLabel.text = @"0";
    missesValueLabel.text = @"0";
    orderedValueLabel.text = @"0";
}

- (void) displayScoresForCounter:(MBMCounter *)counter {
    
    hitsValueLabel.text = [NSString stringWithFormat:@"%d", counter.hits];
    missesValueLabel.text = [NSString stringWithFormat:@"%d", counter.misses];
    orderedValueLabel.text = [NSString stringWithFormat:@"%d", counter.ordered];
    
}

- (void) displayElapsedTime:(NSTimeInterval)elapsedTime {
    if (self.isVisble) {
        timeValueLabel.text = [NSString stringWithFormat:@"%.1fs", elapsedTime];
    }

}

@end
