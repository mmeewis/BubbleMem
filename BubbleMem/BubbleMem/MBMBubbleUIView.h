//
//  MBMBubbleUIView.h
//  BubbleMem
//
//  Created by Marc Meewis on 10/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMBubbleUIView.h"

@class MBMBubbleUIView;

typedef enum {bubbleNormal, bubbleHit, bubbleMiss, bubbleMissFaded, bubbleHitFaded, bubbleBlackWhite} MBMBubbleType;

@protocol MBMBubbleUIViewDelegate <NSObject>

- (void) hideCompletedForBubbleView:(MBMBubbleUIView *)view;
- (void) flyInCompletedForBubbleView:(MBMBubbleUIView *)view;
- (void) moveToGameLocationCompletedForBubbleView:(MBMBubbleUIView *)view;

@end


@interface MBMBubbleUIView : UIView {
    int bubbleIndex;
    BOOL bubbleIsHit;
    
}
  
@property int bubbleIndex;
@property BOOL bubbleIsHit;
@property(nonatomic,assign) id <MBMBubbleUIViewDelegate> delegate;
@property NSTimeInterval timeSinceStart;
@property CGPoint gameLocation;
@property BOOL isLastBubble;
@property (readonly) CGRect gameFrame;
// @property (readonly) CGPoint flyIntoLocation;

- (id)initWithFrame:(CGRect)frame withBubbleType:(MBMBubbleType)bubbleType;

- (void) hideAndFireCompleted:(BOOL)fireCompleted;
- (void) showAs:(MBMBubbleType)bubbleType;
- (void) fadeBubbleType:(MBMBubbleType)bubbleType;
- (void) bringToFront;
- (void) displayIndex;
- (BOOL) containsPoint:(CGPoint)point;

- (void) flyInToLocation:(CGPoint)toLocation withAnimation:(BOOL)animated fireCompleted:(BOOL)fireCompleted;
- (void) moveToGameLocation:(CGPoint)toLocation withAnimation:(BOOL)animated fireCompleted:(BOOL)fireCompleted;

- (void) showShadowBubble:(MBMBubbleType)bubbleType view:(UIView *)view;

@end
