//
//  MBMCounter.h
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBMCounter : NSObject {
    
    NSTimeInterval bestTime, averageTime, elapsedTime, bestElapsedTime;
    int hits, misses, ordered, games, completed, cancelled;
    NSTimeInterval bestReaction, averageReaction, lastReaction;
    
}

@property NSTimeInterval bestTime;
@property NSTimeInterval averageTime;
@property NSTimeInterval elapsedTime;
@property (readonly) NSTimeInterval bestElapsedTime;
@property int hits;
@property int misses;
@property int ordered;
@property int games;
@property int completed;
@property int cancelled;
@property NSTimeInterval bestReaction;
@property NSTimeInterval averageReaction;
@property NSTimeInterval lastReaction;

- (void) reset;
- (void) addValuesFromCounter:(MBMCounter *)counter;
- (void) resetForCancel;

@end
