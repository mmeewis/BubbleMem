//
//  MBMScoreView.m
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMScoreView.h"

@implementation MBMScoreView

@synthesize positionInScrollView;

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

- (void)initValues {
    
}

- (void)displayScoresForCounter:(MBMCounter *)counter {
    
}

- (void)displayElapsedTime:(NSTimeInterval)elapsedTime {
    
}

- (BOOL)isVisble {
    
    // The parent should be the UIScrollView
    
    UIView *parent = [self superview];
    if ([parent isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)parent;
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        if (page == positionInScrollView) {
            return YES;
        }

    }

    return NO;

}

@end
