//
//  MBMBubbleUIView.m
//  BubbleMem
//
//  Created by Marc Meewis on 10/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMBubbleUIView.h"
#import <QuartzCore/QuartzCore.h>


#define MBMBubleDiameter 40
#define MBMBubbleSide 50
#define MBMShadowImageViewTag 10

@implementation MBMBubbleUIView {
    UIImageView *bubleImageView;
    CGPoint flyIntoLocation;
    MBMBubbleUIView *shadowView;
}

@synthesize bubbleIndex;
@synthesize bubbleIsHit;
@synthesize delegate;
@synthesize timeSinceStart;
@synthesize gameLocation;
@synthesize isLastBubble;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bubleImageView = [self bubbleImageViewForBubbleType:bubbleNormal];
        bubleImageView.tag = MBMShadowImageViewTag;
        [self addSubview:bubleImageView];
        self.bubbleIsHit = NO;
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame withBubbleType:(MBMBubbleType)bubbleType
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isLastBubble = NO; // init to False
        bubleImageView = [self bubbleImageViewForBubbleType:bubbleType];
        bubleImageView.tag = MBMShadowImageViewTag;
        [self addSubview:bubleImageView];
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

- (void) hideAndFireCompleted:(BOOL)fireCompleted {
    // animate hiding the the view
    
    [UIView animateWithDuration:1.3 animations:^{
        self.alpha = 0;
    } completion: ^(BOOL finished) {
        if (fireCompleted) {
            if ([delegate respondsToSelector:@selector(hideCompletedForBubbleView:)]) {
                [delegate hideCompletedForBubbleView:self];
            }
        }
    }];
}

- (void) fadeBubbleType:(MBMBubbleType)bubbleType {
    
    [UIView animateWithDuration:0.75 animations:^{
        self.alpha = 0;
    } completion: ^(BOOL finished) {
        self.alpha = 0;
        [bubleImageView removeFromSuperview];
        bubleImageView = [self bubbleImageViewForBubbleType:bubbleType];
        [self addSubview:bubleImageView];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 100;
        } completion: ^(BOOL finished) {
            self.alpha = 100;
        }];

    }];

    


    
}

- (void) showAs:(MBMBubbleType)bubbleType {
    
    if (bubleImageView != nil) {
        [bubleImageView removeFromSuperview];
    }
    
    bubleImageView = [self bubbleImageViewForBubbleType:bubbleType];
    
    [self addSubview:bubleImageView];
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 100;
    } completion: ^(BOOL finished) {
        // self.hidden = NO;
    }];
    
}

- (UIImageView *) bubbleImageViewForBubbleType:(MBMBubbleType)bubbleType {
    
    UIImageView *bView;
    
    switch (bubbleType) {
        case bubbleNormal:
            bView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bubble50x50.png"]];
            break;
        case bubbleHit:
            bView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BubbleHit50x50.png"]];
            break;
        case bubbleMiss:
            bView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BubbleMiss50x50.png"]];
            break;
        case bubbleMissFaded:
            bView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BubbleMissFaded50x50.png"]];
            break;
        case bubbleHitFaded:
            bView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BubbleHitFaded50x50.png"]];
            break;
        case bubbleBlackWhite:
            bView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bubble50x50-BW.png"]];
            break;
        default:
            break;
    }
    
    return bView;
    
}

- (void) bringToFront {
    self.layer.zPosition = 300;
}

- (void) displayIndex {
    
    // index start with 0, so display +1
    
    CGRect indexLabelRect = CGRectMake(self.frame.size.width/2, self.frame.size.height/2 - 7, 20, 20);
    
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:indexLabelRect];
    indexLabel.backgroundColor = [UIColor clearColor];
    indexLabel.text = [NSString stringWithFormat:@"%d", (bubbleIndex +1)];
    indexLabel.textColor = [UIColor grayColor];
    indexLabel.font = [UIFont  boldSystemFontOfSize:15.0];
    [self addSubview:indexLabel];
    
}

- (BOOL) containsPoint:(CGPoint)hitPoint {
    
    // First we test if we hit the png image of the bubble, which is rectangular, however the buble is circular.
    // We need to check if the hit is also with the circle. Otherwise, if the user hits a point in de corners of the
    // rectangle, it looks as if the bubble shows up, even if there was no logical touch.
    
    
    // Bubble center
    
    NSLog(@"origin x: %f, y: %f", self.frame.origin.x, self.frame.origin.y);
    
    float centerX = self.frame.origin.x + MBMBubbleSide / 2;
    float centerY = self.frame.origin.y + MBMBubbleSide / 2;
    
    if (sqrt(((centerX - hitPoint.x) * (centerX - hitPoint.x)) + ((centerY - hitPoint.y) * (centerY - hitPoint.y))) <= (MBMBubleDiameter/2)) {
        NSLog(@"Point is within the circle %f", sqrt(((centerX - hitPoint.x) * (centerX - hitPoint.x)) + ((centerY - hitPoint.y) * (centerY - hitPoint.y))));
        return YES;
    }

    NSLog(@"Point is NOT within the circle %f", sqrt(((centerX - hitPoint.x) * (centerX - hitPoint.x)) + ((centerY - hitPoint.y) * (centerY - hitPoint.y))));
    
    return NO;

}

- (void)flyInToLocation:(CGPoint)toLocation withAnimation:(BOOL)animated fireCompleted:(BOOL)fireCompleted {
    
    flyIntoLocation = toLocation;
    
    [UIView animateWithDuration:0.75 animations:^{
        self.frame = CGRectMake(toLocation.x, toLocation.y, self.frame.size.width, self.frame.size.height);
    } completion: ^(BOOL finished) {
        if (fireCompleted) {
            [delegate flyInCompletedForBubbleView:self];
        }
    }];

}

- (void)moveToGameLocation:(CGPoint)toLocation withAnimation:(BOOL)animated fireCompleted:(BOOL)fireCompleted {

    [UIView animateWithDuration:0.75 animations:^{
        self.frame = CGRectMake(toLocation.x, toLocation.y, self.frame.size.width, self.frame.size.height);
    } completion: ^(BOOL finished) {
        if (fireCompleted) {
            [delegate moveToGameLocationCompletedForBubbleView:self];
        }
    }];

}

- (CGRect) gameFrame {
    return CGRectMake(gameLocation.x, gameLocation.y, MBMBubbleSide, MBMBubbleSide);
}


- (void) showShadowBubble:(MBMBubbleType)bubbleType view:(UIView *)view {
    
    // This method can be called several times with a different bubbleType, therefore we first check if there is
    // already a shadowImageView, if there is, it is removed from the shadowView and replaced by the new image
    // for the selected bubbleType
    
    if (shadowView == nil) {
        CGRect shadowFrame = CGRectMake(flyIntoLocation.x, flyIntoLocation.y, 40, 40);
        shadowView = [[MBMBubbleUIView alloc] initWithFrame:shadowFrame];
        shadowView.bubbleIndex = self.bubbleIndex;
    }
    else {
        
        // This situation can only happen when the UIView already exists
        
        UIView *imageView = [shadowView viewWithTag:MBMShadowImageViewTag];
        if (imageView != nil) {
            [imageView removeFromSuperview];
            imageView = nil;
        }
    }
    
    
    
    UIImageView *shadowImageView = [self bubbleImageViewForBubbleType:bubbleType];
    shadowImageView.tag = MBMShadowImageViewTag;
    [shadowView addSubview:shadowImageView];
    
    [shadowView displayIndex];

    
    [view addSubview:shadowView];
}

- (void)removeFromSuperview {
    NSLog(@"Remove from superView");
    [shadowView removeFromSuperview];
    [super removeFromSuperview];
}

@end
