//
//  MBMUIButton.m
//  BubbleMem
//
//  Created by Marc Meewis on 12/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMUIButton.h"

@implementation MBMUIButton {
    
    MBMButtonState buttonState;
    
}



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

- (void) setButtonState:(MBMButtonState)aButtonState {
    buttonState = aButtonState;
}

- (MBMButtonState) getButtonState {
    return buttonState;
}

@end
