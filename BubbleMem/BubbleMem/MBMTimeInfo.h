//
//  MBMTimeInfo.h
//  BubbleMem
//
//  Created by Marc Meewis on 01/07/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBMTimeInfo : NSObject

@property NSTimeInterval currentTime, lastTime, bestTime;

- (void) updateCurrentTime:(NSTimeInterval)currentTime;

- (NSTimeInterval) currentTimeDisplayValue;
- (NSTimeInterval) bestTimeDisplayValue;
- (NSTimeInterval) lastTimeDisplayValue;


@end
