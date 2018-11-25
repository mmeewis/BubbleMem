//
//  MBMUIButton.h
//  BubbleMem
//
//  Created by Marc Meewis on 12/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {buttonStateStartGame, buttonStateCancelGame, buttonStateNewGame} MBMButtonState;


@interface MBMUIButton : UIButton

- (void) setButtonState:(MBMButtonState)buttonState;
- (MBMButtonState) getButtonState;

@end
