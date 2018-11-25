//
//  GameMessageUIView.h
//  BubbleMem
//
//  Created by Marc Meewis on 21/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {gameMessageCancel, gameMessageComplete} MBMGameMessageType;

@protocol MBMGameMessageUIViewDelegate <NSObject> 
    
    - (void) showGameStatistics;
    
@end

@interface MBMGameMessageUIView : UIView {
    
    UILabel *gameMessageValue;
}

@property UILabel *gameMessageValue;
@property(nonatomic,assign) id <MBMGameMessageUIViewDelegate> delegate;

- (void) showGameMessage:(NSString *)message forType:(MBMGameMessageType)messageType;
- (void) hideGameMessage;

@end
