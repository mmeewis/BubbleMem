//
//  MBMCounter.m
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMCounter.h"

@implementation MBMCounter {
    
}

@synthesize bestTime, averageTime, elapsedTime, bestElapsedTime;
@synthesize bestReaction, averageReaction, lastReaction;
@synthesize hits, misses, ordered, games, completed, cancelled;




- (id) init {
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

- (void) reset {
    bestTime = 0.0;
    averageTime = 0.0;
    bestReaction = 0.0;
    lastReaction = 0.0;
    averageReaction = 0.0;
    hits = 0;
    misses = 0;
    ordered = 0;
    games = 0;
    elapsedTime = 0;
    bestElapsedTime = 0;
    completed = 0;
    cancelled = 0;
    
}

- (void) resetForCancel {
    bestTime = 0.0;
    averageTime = 0.0;
    bestReaction = 0.0;
    lastReaction = 0.0;
    averageReaction = 0.0;
    hits = 0;
    misses = 0;
    ordered = 0;
    games = 0;
    elapsedTime = 0;
}

- (void) addValuesFromCounter:(MBMCounter *)counter {
    bestTime += counter.bestTime;
    averageTime += counter.averageTime;
    bestReaction += counter.bestReaction;
    lastReaction += counter.lastReaction;
    averageReaction += counter.averageReaction;
    hits += counter.hits;
    misses += counter.misses;
    ordered += counter.ordered;
    games += counter.games;
    elapsedTime += counter.elapsedTime;
    completed += counter.completed;
    cancelled += counter.cancelled;
    if (counter.elapsedTime != 0) {
        if ((bestElapsedTime == 0) || (bestElapsedTime > counter.elapsedTime)) {
            bestElapsedTime = counter.elapsedTime;
        }
    }
}

@end
