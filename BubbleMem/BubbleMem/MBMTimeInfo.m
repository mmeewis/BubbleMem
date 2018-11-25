//
//  MBMTimeInfo.m
//  BubbleMem
//
//  Created by Marc Meewis on 01/07/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMTimeInfo.h"

@implementation MBMTimeInfo

@synthesize currentTime, lastTime, bestTime;


- (id)init {
    
    currentTime = 0.0;
    lastTime = 0.0;
    bestTime = -1.0;
    
    return self;
}


- (void) updateCurrentTime:(NSTimeInterval)time {
    
    self.currentTime = time;
    self.lastTime = time;
    if ((self.bestTime > time) || (self.bestTime == -1.0)) {
        self.bestTime = time;
    }
    
}

- (NSTimeInterval) currentTimeDisplayValue {
    return currentTime;
}

- (NSTimeInterval) bestTimeDisplayValue {
    return (bestTime == -1.0 ? 0.0 : bestTime);
}

- (NSTimeInterval) lastTimeDisplayValue {
    return (lastTime == -1.0 ? 0.0 : lastTime);
}

@end
