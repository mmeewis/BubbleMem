//
//  MBMGameUIView.m
//  BubbleMem
//
//  Created by Marc Meewis on 22/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMGameUIView.h"
#import <QuartzCore/QuartzCore.h>
#import "MBMBubbleUIView.h"
#import "MBMGridView.h"

#define MBM_BACKGROUND_VIEW_TAG 20

@implementation MBMGameUIView {
    MBMGridView *gridView;
}

@synthesize delegate;

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

- (void)layoutSubviews {
    
    NSLog(@"Layout subviews MBMGameUIView, backgroundview");
    
    if ([self viewWithTag:MBM_BACKGROUND_VIEW_TAG] == nil) {
        
        NSLog(@"BackgroundImage for MBMGameUIView is not yet added, adding...");
    
        UIImage *backgroundImage = [[UIImage imageNamed:@"gameBackground-blue.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(11, 11, 11, 11) resizingMode:UIImageResizingModeTile];
    
        CGRect bgViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        UIImageView *backgroundView=[[UIImageView alloc] initWithFrame:bgViewRect];
        backgroundView.tag = MBM_BACKGROUND_VIEW_TAG;
        [backgroundView setImage:backgroundImage];

        backgroundView.layer.zPosition = -100;
    
        [self addSubview:backgroundView];
    
    }
    

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"GameView Touch, handing touchesBegan over to delegate");
    [delegate processTouchesBegan:touches withEvent:event inGameView:self];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    NSLog(@"GameView Hit %@", NSStringFromClass([hitView class]));
    
    if (hitView == self) {
        return hitView;
    }
    else {
        if ( [NSStringFromClass([hitView class]) isEqual:@"MBMBubbleUIView"]) {
            MBMBubbleUIView *bubble = (MBMBubbleUIView *) hitView;
            if (bubble.bubbleIsHit) {
                return nil; // We are hitting a hit, do not display an addtional miss button
            }
            else {
                return self; // if a bubble is hit, the touch should be forwarded to the gameView
            }
        }
    }
    return nil;
}

- (void) handleInterfaceRotation {
    UIImageView *backgroundView = (UIImageView *) [self viewWithTag:MBM_BACKGROUND_VIEW_TAG];
        
    [backgroundView removeFromSuperview];
        
    //    [self addBackgroundForView:[self gameView]];
        
}


- (void) addGridViewWithFrame:(CGRect)frame {
    
    gridView = [[MBMGridView alloc] initWithFrame:frame];
    [self addSubview:gridView];
    
}

- (void) removeGridView {
    if (gridView != nil) {
        [gridView removeFromSuperview];
        gridView = nil;
    }
}

- (MBMGridView *) gridView {
    return gridView;
}

@end
