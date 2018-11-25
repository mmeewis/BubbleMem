//
//  MBMStartView.m
//  BubbleMem
//
//  Created by Marc Meewis on 30/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMStartView.h"

@implementation MBMStartView {
    UIView *overlayTop, *overlayBottom, *overlayLeft, *overlayRight;
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addOverlays];
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

- (void) addOverlays {
    
    NSLog(@"layoutSubview");
    
    CGRect overlayTopFromFrame = CGRectMake(0, 0, self.frame.size.width, 0);
    CGRect overlayTopToFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2);

    CGRect overlayBottomFromFrame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
    CGRect overlayBottomToFrame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height /2);

    CGRect overlayLeftFromFrame = CGRectMake(0, 0, 0, self.frame.size.height);
    CGRect overlayLeftToFrame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);

    // CGRect overlayRightFromFrame = CGRectMake(self.frame.size.width, self.frame.size.height, 0, self.frame.size.height);
    // CGRect overlayRightToFrame = CGRectMake(self.frame.size.width, self.frame.size.height, self.frame.size.width /2, self.frame.size.height);

    CGRect overlayRightFromFrame = CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height);
    CGRect overlayRightToFrame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width /2, self.frame.size.height);

    overlayTop = [[UIView alloc] initWithFrame:overlayTopFromFrame];
    overlayTop.alpha = 0.3;
    overlayTop.backgroundColor = [UIColor greenColor];

    overlayBottom = [[UIView alloc] initWithFrame:overlayBottomFromFrame];
    overlayBottom.alpha = 0.3;
    overlayBottom.backgroundColor = [UIColor greenColor];

    overlayLeft = [[UIView alloc] initWithFrame:overlayLeftFromFrame];
    overlayLeft.alpha = 0.3;
    overlayLeft.backgroundColor = [UIColor greenColor];

    overlayRight = [[UIView alloc] initWithFrame:overlayRightFromFrame];
    overlayRight.alpha = 0.3;
    overlayRight.backgroundColor = [UIColor greenColor];

    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         overlayTop.frame = overlayTopToFrame;
                         overlayBottom.frame = overlayBottomToFrame;
                         overlayLeft.frame = overlayLeftToFrame;
                         overlayRight.frame = overlayRightToFrame;
                     }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.3
                                animations:^{
                                        overlayTop.alpha = 0;
                                        overlayBottom.alpha = 0;
                         
                                }
                                completion:^(BOOL finished){
                                    
                                    [delegate startViewAnimationCompleted:self];
                                    
                                    [overlayTop removeFromSuperview];
                                    [overlayBottom removeFromSuperview];
                                    [overlayLeft removeFromSuperview];
                                    [overlayRight removeFromSuperview];
                                    overlayTop = nil;
                                    overlayBottom = nil;
                                    overlayRight = nil;
                                    overlayLeft = nil;
                                }
                          ];
                         
                         
                     }];

    
    [self addSubview:overlayTop];
    [self addSubview:overlayBottom];
    [self addSubview:overlayRight];
    [self addSubview:overlayLeft];
    
}

@end
