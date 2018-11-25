//
//  MBMGridView.m
//  BubbleMem
//
//  Created by Marc Meewis on 02/07/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMGridView.h"

@implementation MBMGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSLog(@"GameView Height : %f, width : %f", self.frame.size.height, self.frame.size.width);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, self.frame.size.height / 2.0, 0); //start at this point
    
    CGContextAddLineToPoint(context, self.frame.size.height / 2.0, self.frame.size.width); //draw to this point

    CGContextMoveToPoint(context, 0.0, self.frame.size.width / 2.0); //start at this point
    
    CGContextAddLineToPoint(context, self.frame.size.height, self.frame.size.width / 2.0); //draw to this point

    
    // and now draw the Path!
    CGContextStrokePath(context);
}

@end
