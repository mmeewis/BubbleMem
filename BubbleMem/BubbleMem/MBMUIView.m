//
//  MBMUIView.m
//  BubbleMem
//
//  Created by Marc Meewis on 22/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMUIView.h"

@implementation MBMUIView

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

/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    NSLog(@"MBMUIView Hit %@", NSStringFromClass([hitView class]));
    
    return hitView;
}
 */

@end
