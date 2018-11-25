//
//  MBMStartView.h
//  BubbleMem
//
//  Created by Marc Meewis on 30/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBMStartView;

@protocol MBMStarViewDelegate <NSObject>

- (void) startViewAnimationCompleted:(MBMStartView *)startView;

@end

@interface MBMStartView : UIView

@property(nonatomic,assign) id <MBMStarViewDelegate> delegate;


@end
