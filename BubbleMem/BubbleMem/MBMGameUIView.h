//
//  MBMGameUIView.h
//  BubbleMem
//
//  Created by Marc Meewis on 22/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMGameUIView.h"
#import "MBMGridView.h"

@class MBMGameUIView;

@protocol MBMGameUIViewDelegate <NSObject>

    - (void) processTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inGameView:(MBMGameUIView *)gameView;

@end

@interface MBMGameUIView : UIView

@property(nonatomic,assign) id <MBMGameUIViewDelegate> delegate;

- (void) handleInterfaceRotation;
- (void) addGridViewWithFrame:(CGRect)frame;
- (void) removeGridView;
- (MBMGridView *) gridView;

@end
