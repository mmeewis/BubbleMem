//
//  GameMessageUIView.m
//  BubbleMem
//
//  Created by Marc Meewis on 21/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMGameMessageUIView.h"
#import <QuartzCore/QuartzCore.h>

#define MBM_MESSAGE_VIEW_SUBVIEW_TAG 30

@implementation MBMGameMessageUIView

@synthesize gameMessageValue;
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


- (void) showGameMessage:(NSString *)message forType:(MBMGameMessageType)messageType {
    
    // Always on top
    
    UIImage *backgroundImage;
    
    
    switch (messageType) {
        case gameMessageCancel:
            gameMessageValue.textColor = [UIColor redColor];
            backgroundImage = [[UIImage imageNamed:@"messageBackground-Red.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(11, 11, 11, 11) resizingMode:UIImageResizingModeStretch];
            break;
        case gameMessageComplete:
            gameMessageValue.textColor = [UIColor greenColor];
            backgroundImage = [[UIImage imageNamed:@"messageBackground-Green.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(11, 11, 11, 11) resizingMode:UIImageResizingModeStretch];
            break;
        default:
            break;
    }
    
    self.layer.zPosition = 199;
    self.backgroundColor = [UIColor clearColor];
    
    
    /*
    if (messageType == gameMessageComplete) {
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        // [button setTitle:@"Start Game" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button addTarget:self action:@selector(showGameStatistics:) forControlEvents:UIControlEventTouchUpInside];
        
        button.layer.zPosition = 201;
        button.userInteractionEnabled = YES;
        button.tag = MBM_MESSAGE_VIEW_SUBVIEW_TAG;

        [self addSubview:button];

    }
    else {
    */
        UIImageView *background = [[UIImageView alloc] initWithImage:backgroundImage];
        background.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
        background.tag = MBM_MESSAGE_VIEW_SUBVIEW_TAG;
        
        [self addSubview:background];
    /*
    }
    */
    
    /*
    
    UIImageView *background = [[UIImageView alloc] initWithImage:backgroundImage];
    background.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    background.tag = MBM_MESSAGE_VIEW_BACKGROUND_IMAGE_VIEW_TAG;
     */

    //[gameMessageView sendSubviewToBack:background];
    //gameMessageView.contentMode = UIViewContentModeScaleToFill;
    
    /*
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
    */
    
    gameMessageValue.layer.zPosition = 200;
    
    gameMessageValue.text = message;
    gameMessageValue.hidden = NO;
    self.hidden = NO;
    
    self.userInteractionEnabled = YES;
    
}

- (void) hideGameMessage {
    gameMessageValue.text = @"";;
    gameMessageValue.textColor = [UIColor clearColor];
    gameMessageValue.hidden = YES;
    
    // subview can be button or image, depending on messageType passed in showMessage
    
    UIView *subView = [self viewWithTag:MBM_MESSAGE_VIEW_SUBVIEW_TAG];
    
    [subView removeFromSuperview];
    
    self.hidden = YES;
    self.userInteractionEnabled = NO;
}

- (void) showGameStatistics:(id)sender {
    NSLog(@"Button is touched");
    [delegate showGameStatistics];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"MBMGameMessageUIView is touched");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"MBMGameMessageUIView is touched");
}

/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    NSLog(@"GameMessageView Hit %@", NSStringFromClass([hitView class]));
    
    return hitView;
}
 */

@end
