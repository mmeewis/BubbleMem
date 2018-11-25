//
//  MBMViewController.m
//  BubbleMem
//
//  Created by Marc Meewis on 10/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMViewController.h"
#import "MBMBubbleUIView.h"
#import "MBMUIButton.h"
#import "MBMGameUIView.h"
#import "MBMControlUIView.h"
#import "MBMGameStatisticsViewController.h"
#import "MBMTimingsScoreView.h"
#import "MBMTouchesScoreView.h"
#import "MBMReactionScoreView.h"
#import "MBMGamesScoreView.h"
#import "MBMCounter.h"
#import "MBMStartView.h"
#import "MBMLocation.h"
#import "MBMTimingViewController.h"
#import "MBMCountingViewController.h"
#import "MBMTimeInfo.h"

#import <QuartzCore/QuartzCore.h>


#define MBM_GAME_VIEW_TAG 2
#define MBM_CONTROL_VIEW_TAG 1
#define MBM_SHADOW_VIEW_TAG 4
#define MBM_GAME_CONTROL_BTN_TAG 10
#define MBM_INITIAL_BUBBLE_LOCATION_Y 2
#define MBM_NBR_OF_BUBBLES 4
#define MBM_CIRCLE_R 200


@interface MBMViewController () {
    
    NSMutableArray *bubbles;
    NSMutableArray *bubblesHit;
    NSMutableArray *bubblesMiss;
    
    UIButton *startButton;
    NSTimer *hideBubbleTimer;
    NSTimer *addBubbleTimer;
    NSTimer *currentGameTimer;
    
    int hits;
    // int currentGameHits;
    int misses;
    int currentGameMisses;
    NSTimeInterval currentGameTime;
    int nbrOfBubbles;
    int completedGames;
    int cancelledGames;
    NSTimeInterval bestGameTime;
    NSTimeInterval avgGameTime;
    NSTimeInterval totalGameTime;
    
    NSArray *scoreViews;
    NSArray *scoreViewTitles;
    
    // Counters
    
    // Timings
    
    MBMCounter *gameCounter, *sessionCounter, *overallCounter;
    
    NSMutableArray *gameLevelScoreViews, *sessionLevelScoreViews, *overallLevelScoreViews;
    
    CGPoint bubbleInitLocation;
    
    MBMTimingViewController *timingViewController;
    MBMCountingViewController *countingViewController;
    
    MBMTimeInfo *timeInfo;
    
}

@end

@implementation MBMViewController

/*
@synthesize hitsValue;
@synthesize missesValue;
@synthesize timeInfoValue;
@synthesize completedGamesValue;
@synthesize cancelledGamesValue;
@synthesize bestGameTimeValue;
@synthesize avgGameTimeValue;

@synthesize hitsInOrderValue;
*/

@synthesize gameMessageValue;
@synthesize timingPlaceHolderView;

// @synthesize scrollView;
// @synthesize pageControl;
@synthesize gameMessageView = _gameMessageView;

BOOL pageControlBeingUsed;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initVars];
    [self initGame];
    [self addStartStopButton];
    
    [self gameView].delegate = self;
    [self gameMessageView].delegate = self;
    
    // [self addBackgroundForView:[self gameView]];
    
    // [self addBubble];
    
    /*
    scoreViewTitles = [[NSArray alloc] initWithObjects:@"Overall Timings", @"Session Timings", @"Overall Touches", @"Session Touches", @"Game Touches", @"Overall Reaction", @"Session Reaction", @"Game Reaction", @"Overall Games", @"Session Games", nil];
    
    scoreViews = [self loadScoreViews];
    
    for (int i = 0; i < scoreViews.count; i++) {
        MBMScoreView *scoreView = (MBMScoreView *)[scoreViews objectAtIndex:i];
        scoreView.positionInScrollView = i;
        [self.scrollView addSubview:scoreView];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * scoreViews.count, self.scrollView.frame.size.height);
    
    scrollView.delegate = self;
    pageControlBeingUsed = NO;
    
    pageControl.numberOfPages = [scoreViews count];
    */
    
    // Add the timingViewController
    
    timingViewController = [[MBMTimingViewController alloc] init];
    CGRect timingViewFrame = CGRectMake(0,0,timingPlaceHolderView.frame.size.width, timingPlaceHolderView.frame.size.height);
    timingViewController.view.frame = timingViewFrame;
    NSLog(@"PlaceHolderFrame width %f   , height %f", timingPlaceHolderView.frame.size.width, timingPlaceHolderView.frame.size.height);
    
    
    [self addChildViewController:timingViewController];
    
    // [timingViewController fillWithColor:[UIColor redColor]];
    [timingPlaceHolderView addSubview:timingViewController.view];
    
    // [timingViewController animateTiming];
    
    countingViewController = [[MBMCountingViewController alloc] init];
    countingViewController.delegate = self;
    
    CGRect gameViewRect = [[self gameView] frame];
    CGRect shadowViewRect = [[self shadowView] frame];
    CGRect gridViewRect = CGRectMake(0, shadowViewRect.size.height + 10.0, gameViewRect.size.width, gameViewRect.size.height - 5.0);
    
    [[self gameView] addGridViewWithFrame:gridViewRect];
    
}

/*
- (NSArray *) loadScoreViews {
    NSMutableArray * views = [[NSMutableArray alloc] init];
    
    // Overall Timings
    // Session Timings
    
    MBMTimingsScoreView *overallTimingsView = [self instantiateTimingsScoreView];
    overallTimingsView.frame = [self frameForScrollViewPosition:UIViewOverallTimings];
    overallTimingsView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewOverallTimings];
    [overallTimingsView initValues];
    [views addObject:overallTimingsView];
    [overallLevelScoreViews addObject:overallTimingsView];
    
    MBMTimingsScoreView *sessionTimingsView = [self instantiateTimingsScoreView];
    sessionTimingsView.frame = [self frameForScrollViewPosition:UIViewSessionTimings];
    sessionTimingsView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewSessionTimings];
    [sessionTimingsView initValues];
    [views addObject:sessionTimingsView];
    [sessionLevelScoreViews addObject:sessionTimingsView];


    // Overall Touches
    // Session Touches
    // Game Touches

    MBMTouchesScoreView *overallTouchesView = [self instantiateTouchesScoreView];
    overallTouchesView.frame = [self frameForScrollViewPosition:UIViewOverallTouches];
    overallTouchesView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewOverallTouches];
    [overallTouchesView initValues];
    [views addObject:overallTouchesView];
    [overallLevelScoreViews addObject:overallTouchesView];

    MBMTouchesScoreView *sessionTouchesView = [self instantiateTouchesScoreView];
    sessionTouchesView.frame = [self frameForScrollViewPosition:UIViewSessionTouches];
    sessionTouchesView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewSessionTouches];
    [sessionTouchesView initValues];
    [views addObject:sessionTouchesView];
    [sessionLevelScoreViews addObject:sessionTouchesView];

    MBMTouchesScoreView *gameTouchesView = [self instantiateTouchesScoreView];
    gameTouchesView.frame = [self frameForScrollViewPosition:UIViewGameTouches];
    gameTouchesView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewGameTouches];
    [gameTouchesView initValues];
    [views addObject:gameTouchesView];
    [gameLevelScoreViews addObject:gameTouchesView];

    
    // Overall Reaction
    // Session Reaction
    // Game Reaction

    MBMReactionScoreView *overallReactionView = [self instantiateReactionScoreView];
    overallReactionView.frame = [self frameForScrollViewPosition:UIViewOverallReaction];
    overallReactionView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewOverallReaction];
    [overallReactionView initValues];
    [views addObject:overallReactionView];
    [overallLevelScoreViews addObject:overallReactionView];

    MBMReactionScoreView *sessionReactionView = [self instantiateReactionScoreView];
    sessionReactionView.frame = [self frameForScrollViewPosition:UIViewSessionReaction];
    sessionReactionView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewSessionReaction];
    [sessionReactionView initValues];
    [views addObject:sessionReactionView];
    [sessionLevelScoreViews addObject:sessionReactionView];

    MBMReactionScoreView *gameReactionView = [self instantiateReactionScoreView];
    gameReactionView.frame = [self frameForScrollViewPosition:UIViewGameReaction];
    gameReactionView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewGameReaction];
    [gameReactionView initValues];
    [views addObject:gameReactionView];
    [gameLevelScoreViews addObject:gameReactionView];
    
    // Overall Games
    // Session Games

    MBMGamesScoreView *overallGamesView = [self instantiateGamesScoreView];
    overallGamesView.frame = [self frameForScrollViewPosition:UIViewOverallGames];
    overallGamesView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewOverallGames];
    [overallGamesView initValues];
    [views addObject:overallGamesView];
    [overallLevelScoreViews addObject:overallGamesView];

    
    MBMGamesScoreView *sessionGamesView = [self instantiateGamesScoreView];
    sessionGamesView.frame = [self frameForScrollViewPosition:UIViewSessionGames];
    sessionGamesView.titleLabel.text = [scoreViewTitles objectAtIndex:UIViewSessionGames];
    [sessionGamesView initValues];
    [views addObject:sessionGamesView];
    [sessionLevelScoreViews addObject:sessionGamesView];


    return views;
    
}
*/

- (UIView *) scoreViewAtPosition:(MBMScoreViewType)position {
    return [scoreViews objectAtIndex:position];
}

- (MBMTimingsScoreView *) instantiateTimingsScoreView {
    UINib *timingsNib = [UINib nibWithNibName:@"MBMTimingsScoreView" bundle:nil];
    return [[timingsNib instantiateWithOwner:self options:nil] objectAtIndex:0];
}

- (MBMGamesScoreView *) instantiateGamesScoreView {
    UINib *timingsNib = [UINib nibWithNibName:@"MBMGamesScoreView" bundle:nil];
    return [[timingsNib instantiateWithOwner:self options:nil] objectAtIndex:0];
}


- (MBMTouchesScoreView *) instantiateTouchesScoreView {
    UINib *timingsNib = [UINib nibWithNibName:@"MBMTouchesScoreView" bundle:nil];
    return [[timingsNib instantiateWithOwner:self options:nil] objectAtIndex:0];
}

- (MBMReactionScoreView *) instantiateReactionScoreView {
    UINib *timingsNib = [UINib nibWithNibName:@"MBMReactionScoreView" bundle:nil];
    return [[timingsNib instantiateWithOwner:self options:nil] objectAtIndex:0];
}

/*
- (CGRect) frameForScrollViewPosition:(int)position {
    
    CGRect frame;
    
    frame.origin.x = self.scrollView.frame.size.width * position;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    return frame;
 
}
*/


- (void) initVars {
    bubbles = [[NSMutableArray alloc] init];
    bubblesMiss = [[NSMutableArray alloc] init];
    bubblesHit = [[NSMutableArray alloc] init];
    hits = 0;
    misses = 0;
    nbrOfBubbles = MBM_NBR_OF_BUBBLES;
    completedGames = 0;
    cancelledGames = 0;
    bestGameTime = 0;
    avgGameTime = 0;
    totalGameTime = 0;
    // currentGameHits = 0;
    currentGameMisses = 0;
    
    gameCounter = [[MBMCounter alloc] init];
    sessionCounter = [[MBMCounter alloc] init];
    overallCounter = [[MBMCounter alloc] init];
    
    gameLevelScoreViews = [[NSMutableArray alloc] init];
    sessionLevelScoreViews = [[NSMutableArray alloc] init];
    overallLevelScoreViews = [[NSMutableArray alloc] init];
    
    bubbleInitLocation = CGPointMake([self gameView].frame.size.width, MBM_INITIAL_BUBBLE_LOCATION_Y);
    
    timeInfo = [[MBMTimeInfo alloc] init];
    
}

- (void) initGame {
    [self userInteractionAllowed:NO forView:[self gameView]];
    [self.gameMessageView hideGameMessage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addStartStopButton {
    
    UIImage *btnImage = [[UIImage imageNamed:@"GreyButton20x20.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(11, 11, 11, 11) resizingMode:UIImageResizingModeStretch];
    
    
    MBMUIButton *button = [MBMUIButton buttonWithType:UIButtonTypeCustom];
    [button setButtonState:buttonStateStartGame];
    button.tag = MBM_GAME_CONTROL_BTN_TAG;
    
    NSLog(@"ControlView Height : %f, Width : %f", CGRectGetHeight([[self controlView] frame]), CGRectGetWidth([[self controlView] frame]));
    
    //the button should be as big as a table view cell
    [button setFrame:CGRectMake(10, 5, CGRectGetWidth([[self controlView] frame]) - 20.0, 45)];
    
    [button setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    //set title, font size and font color
    [button setTitle:@"Start Game" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [button addTarget:self action:@selector(startStopGame:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self controlView] addSubview:button];

}

- (MBMBubbleUIView *) addBubbleWithIndex:(int)index withBubbleType:(MBMBubbleType)bubbleType atLocation:(CGPoint)location{
    
    // int randomX = (arc4random() % 300) + 40;
    // int randomY = (arc4random() % 300) + 40;

    CGRect bubbleFrame = CGRectMake(location.x, location.y, 40.0, 40.0);
    
    MBMBubbleUIView *bubbleView = [[MBMBubbleUIView alloc] initWithFrame:bubbleFrame withBubbleType:bubbleType];
    
    bubbleView.bubbleIndex = index;
    
    bubbleView.layer.zPosition = 200;
    
    // [[self gameView] addSubview:bubbleView];
    
    return bubbleView;
    
    
}


// This method has been replaced by by processTouchesBegan, this method is calles from MBMGameUIView
// When this view is touched, this viewController serves as a delegate

- (void)touchesBeganNotUsed:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // We will only validate the first touch the see if there is a hit
    
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    
    bool isHit = NO;
    
    // Is the touch in within the boundaries of the gameView, only then proceed
    
    
    NSLog(@"Touch Info :");
    NSLog(@"GameView Frame x: %f, y: %f, width: %f, height: %f", [[self gameView] frame].origin.x, [[self gameView] frame].origin.y, [[self gameView] frame].size.width,[[self gameView] frame].size.height );
    NSLog(@"Location in view x: %f, y: %f", [touch locationInView:[self view]].x, [touch locationInView:[self view]].y);
    
    
    if (CGRectContainsPoint([[self gameView] frame], [touch locationInView:[self view]]) && ([self gameView].userInteractionEnabled)) {
    
        for(MBMBubbleUIView *bubble in bubbles)
        {
        

            if ((CGRectContainsPoint([bubble frame], [touch locationInView:[self gameView]])) && (!bubble.bubbleIsHit)) {
                NSLog(@"BubbleView is touched %d", bubble.bubbleIndex);
                bubble.bubbleIsHit = YES;
                bubble.timeSinceStart = currentGameTime;
                NSLog(@"bubble.timeSinceStart %.2f", bubble.timeSinceStart);
                [bubble showAs:bubbleHit];
                isHit = YES;
                [bubble bringToFront];
                
                hits++;
                // --MME hitsValue.text = [NSString stringWithFormat:@"%d",hits];
                // currentGameHits++;
                
                [bubblesHit addObject:bubble];
                
                [self updateHitsInOrder];
                
                if (bubblesHit.count == (nbrOfBubbles)) {
                    [self completeGame];
                }
                
                break;
            }
        
        }
    
        if (!isHit) {
        
            // None of the bubbles is touched
                
            NSLog(@"BubbleView is Missed");
        
            CGPoint location = CGPointMake([touch locationInView:[self gameView]].x -20.0, [touch locationInView:[self gameView]].y - 20.0);
        
            MBMBubbleUIView *bview = [self addBubbleWithIndex:0 withBubbleType:bubbleMiss atLocation:location];
            [[self gameView] addSubview:bview];
            
            [bview fadeBubbleType:bubbleMissFaded];
        
            [bubblesMiss addObject:bview];
            
            misses++;
            // --MME missesValue.text = [NSString stringWithFormat:@"%d",misses];
            currentGameMisses++;
        
        }
        
    }
    else {
        NSLog(@"Touch outside of gameView or interaction not allowed");
        
        // [self.gameMessageView nextResponder];
    }
    
}

- (void) startStopGame:(id)sender {
    
    MBMUIButton *button = (MBMUIButton *)sender;
    
    switch ([button getButtonState]) {
        case buttonStateStartGame:
            // When the button is in this state, the game will actually start when pressed, the
            // new state "buttonStateCancelGame" will allow the user to stop the game
            [self startGame];
            [button setButtonState:buttonStateCancelGame];
            [button setTitle:@"Cancel Game" forState:UIControlStateNormal];
            break;
        case buttonStateCancelGame:
            // When the button is pressed when it is in this state, the game will stop, the next state
            // will allow the user to start a new game
            [button setButtonState:buttonStateNewGame];
            [button setTitle:@"New Game" forState:UIControlStateNormal];
            [self cancelGame];
            break;
        case buttonStateNewGame:
            // In the button is clicked in state NewGame, the screen will be reset and the
            // Button will display "Start Game", the new state for the button will be
            // buttonStateStartGame
            [button setButtonState:buttonStateStartGame];
            [button setTitle:@"Start Game" forState:UIControlStateNormal];
            [self newGame];
            break;
            
        default:
            break;
    }
    
}

- (void) startGame {

    // Add bubbles
    
    // nbrOfGames++;
    // nbrOfGamesValue.text = [NSString stringWithFormat:@"%d",nbrOfGames];
    
    // reset the gameCounter

    [timingViewController resetTiming];
    [timingViewController initTimingWithReferenceTime:[sessionCounter bestElapsedTime] andMaxTime:4.0];

    [gameCounter reset];
    
    
    // update game level timers
    
    currentGameMisses = 0;
    // currentGameHits = 0;
    currentGameTime = 0;
    [self updateTimers:gameCounter.elapsedTime];
    [self updateTimeInfoDisplay:timeInfo];
    
        
    
    // NSLog(@"View Width : %f, Height : %f", [[self gameView] frame].size.width, [[self gameView] frame].size.height);
    
    for(int i=0; i < nbrOfBubbles; i++) {
        
        NSLog(@"Adding bubble with index : %d", i);
        
        // float randomX = (arc4random() % (((int)[[self gameView] frame].size.width) - 50)) + 1;
        // float randomY = (arc4random() % (((int)[[self gameView] frame].size.height) - 50)) + 1;
        
        
        // NSLog(@"RandomX : %f, RandomY : %f", randomX, randomY);
        

        // Avoid overlapping bubbles, check if the location is already used, if so select a new
        // random location
        
        BOOL locationIsFine = NO;
        
        CGPoint bubbleLocation = [self randomLocation];

        while (!locationIsFine) {
            
            NSLog(@"Adding bubble with index : %d at x : %f, y: %f", i, bubbleLocation.x, bubbleLocation.y);
            
            if (bubbles.count != 0) {
            
                for(MBMBubbleUIView *bubble in bubbles)
                {
                    NSLog(@"checking bubble : %d", bubble.bubbleIndex);
                    
                    if (CGRectIntersectsRect(bubble.gameFrame, CGRectMake(bubbleLocation.x, bubbleLocation.y, bubble.gameFrame.size.width, bubble.gameFrame.size.height))) {
                        locationIsFine = NO;
                        NSLog(@"Location is NOT Fine");
                        
                        // MBMBubbleUIView *nview = [self addBubbleWithIndex:i withBubbleType:bubbleHitFaded atLocation:location];
                        
                        // [nview displayIndex];

                        break;
                    }
                    else {
                        locationIsFine = YES;
                        NSLog(@"Location is Fine");
                    }
                }
            }
            else {
                // The first bubble is always ok
                locationIsFine = YES;
            }
            
            if (locationIsFine) {
                break;
                NSLog(@"Breajkinge");
            }
            
            NSLog(@"New Location");
            bubbleLocation = [self randomLocation];
            
        }
        
        
        MBMBubbleUIView *bview = [self addBubbleWithIndex:i withBubbleType:bubbleNormal atLocation:bubbleInitLocation];
        bview.gameLocation = bubbleLocation;
        bview.delegate = self;
        [[self gameView] addSubview:bview];
        
        [bubbles addObject:bview];

        // adding the bubbles is delayed to the addBubblesAnimated method
        
        /*
        MBMBubbleUIView *bview = [self addBubbleWithIndex:i withBubbleType:bubbleNormal atLocation:location];
        [bview displayIndex];
        
        [bubbles addObject:bview];
        */
        
    }
    
    ((MBMBubbleUIView *)[bubbles lastObject]).isLastBubble = YES;
    
    [self addBubblesWithAnimation:YES];
    
}

- (CGPoint) randomLocation {
    
    float randomX = (arc4random() % (((int)[[self gameView] frame].size.width) - 50)) + 1;
    float randomY = 50 + (arc4random() % (((int)[[self gameView] frame].size.height) - 100)) + 1;
    
    return CGPointMake(randomX, randomY);
}

- (void) completeGame {

    completedGames++;
    
    gameCounter.completed++;
    gameCounter.elapsedTime = currentGameTime;
    
    [sessionCounter addValuesFromCounter:gameCounter];
    [self displaySessionLevelScoresForCounter:sessionCounter];
    
    // --MME completedGamesValue.text = [NSString stringWithFormat:@"%d",completedGames];
    
    [self.gameMessageView showGameMessage:@"Game Completed" forType:gameMessageComplete];
    
    [[self controlButton] setButtonState:buttonStateNewGame];
    [[self controlButton] setTitle:@"New Game" forState:UIControlStateNormal];
    
    [currentGameTimer invalidate];
    
    [self userInteractionAllowed:NO forView:[self gameView]];
    [self updateGameTimeValues:gameCounter.elapsedTime];
    
    [self updateTimeInfo:currentGameTime];
    
    
}

- (void) cancelGame {

    [currentGameTimer invalidate];
    currentGameTimer = nil;
    
    [self revealMisses];
    
    [self.gameMessageView showGameMessage:@"Game Cancelled" forType:gameMessageCancel];
    
    gameCounter.cancelled++;
    
    // We do not care about the timings when a game is cancelled, so set them to 0
    
    [gameCounter resetForCancel];
    [sessionCounter addValuesFromCounter:gameCounter];
    [self displaySessionLevelScoresForCounter:sessionCounter];
    
    // hits -= bubblesHit.count;
    // misses -= currentGameMisses;
    // cancelledGames++;
    
    // --MME hitsValue.text = [NSString stringWithFormat:@"%d",hits];
    // --MME missesValue.text = [NSString stringWithFormat:@"%d",misses];
    // --MME cancelledGamesValue.text = [NSString stringWithFormat:@"%d",cancelledGames];

    
    // update the calculated times with the negative time
    
    [self updateGameTimeValues:-currentGameTime];
    
    currentGameTime = 0;
    
    [self userInteractionAllowed:NO forView:[self gameView]];

}

- (void) newGame {
    [self.gameMessageView hideGameMessage];
    [self removeBubbles];
    

}

- (void) hideBubbles {
    
    int i = 0;
    
    for (MBMBubbleUIView *bview in bubbles) {
        i++;
        if (i== nbrOfBubbles) {
            [bview hideAndFireCompleted:YES];
        }
        else {
            [bview hideAndFireCompleted:NO];
        }
    }
    
}


- (void) hideTimerFires {
    
    NSLog(@"HideTimerExpires");
    
    [self hideBubbles];
    
    [self addChildViewController:countingViewController];
    
    CGRect countingFrame = CGRectMake([self gameView].frame.size.width /2 - MBM_COUNTERVALUE_VIEW_END_SIZE /2, [self gameView].frame.size.height /2 - MBM_COUNTERVALUE_VIEW_END_SIZE /2, MBM_COUNTERVALUE_VIEW_END_SIZE, MBM_COUNTERVALUE_VIEW_END_SIZE);
    
    countingViewController.view.frame = countingFrame;
    
    [self.view addSubview:countingViewController.view];
    
    [countingViewController count:down animationDuration:1.3];
    
    
    // The timing/userinteractionenabled of the game starts when the last bubble is hidden. This controller is alerted
    // via its delegate method, MBMBubbleUIViewDelegate hideCompletedForBubbleView:(UIView *)view

    
}

- (void) removeBubbles {
    
    [self removeBubblesWithAnimation];
    
    [bubblesHit removeAllObjects];
    
    if (hideBubbleTimer != nil) {
        [hideBubbleTimer invalidate];
    }
    
    for (int i=0; i<bubbles.count; i++) {
        MBMBubbleUIView *bubble = [bubbles objectAtIndex:i];
        [bubble removeFromSuperview];
        bubble = nil; // set to nil to garbage collect
    }
    
    /*
    for (MBMBubbleUIView *bubble in bubbles) {
        [bubble removeFromSuperview];
        // bubble = nil;
    }
    */

    [bubbles removeAllObjects];


    for (int i=0; i<bubblesMiss.count; i++) {
        MBMBubbleUIView *bubble = [bubblesMiss objectAtIndex:i];
        [bubble removeFromSuperview];
        bubble = nil; // set to nil to garbage collect
    }
    
    /*
    for (MBMBubbleUIView *bubbleMiss in bubblesMiss) {
        [bubbleMiss removeFromSuperview];
    }
    */
    
    [bubblesMiss removeAllObjects];
    
    
}

- (MBMGameUIView *) gameView {
    return (MBMGameUIView *)[self.view viewWithTag:MBM_GAME_VIEW_TAG];
}

- (MBMControlUIView *) controlView {
    return (MBMControlUIView *)[self.view viewWithTag:MBM_CONTROL_VIEW_TAG];
}

- (MBMUIButton *) controlButton {
    return (MBMUIButton *)[[self controlView] viewWithTag:MBM_GAME_CONTROL_BTN_TAG];
}

- (UIView *) shadowView {
    return [self.view viewWithTag:MBM_SHADOW_VIEW_TAG];
}

- (void) timeGame {
    
    if (currentGameTimer !=nil) {
        if ([currentGameTimer isValid]) {
            [currentGameTimer invalidate];
            currentGameTimer = nil;
        }
    }
    
    currentGameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateGameTime) userInfo:nil repeats:YES];

}

- (void) updateGameTime {
    NSTimeInterval interval = [currentGameTimer timeInterval];
    currentGameTime += interval;
    [self updateTimers:currentGameTime];
    // [timingViewController updateTiming:currentGameTime];
}

- (void) updateTimers:(NSTimeInterval)timeInSeconds {
    
    [timingViewController updateTiming:timeInSeconds];
    
    [self displayCurrentTime:timeInSeconds];
    
    [self displayElapsedTime:timeInSeconds];
    
    
    // NSLog(@"TimeInterval %f", timeInSeconds);
    // --MME timeInfoValue.text = [NSString stringWithFormat:@"%.2fs",timeInSeconds];
    // MME totalsScoreView.timeValueLabel.text = [NSString stringWithFormat:@"%.2fs",timeInSeconds];
    // MME timingsScoreView.timeValueLabel.text = [NSString stringWithFormat:@"%.2fs",timeInSeconds];
    //if (completedGames == 0) {
        // MME timingsScoreView.bestTimeValueLabel.text = [NSString stringWithFormat:@"%.2fs",timeInSeconds];
        // MME timingsScoreView.averageTimeValueLabel.text = [NSString stringWithFormat:@"%.2fs",timeInSeconds];
    //}
}

- (void) userInteractionAllowed:(BOOL)allow forView:(UIView *)view {
    view.userInteractionEnabled = allow;
}

- (void) updateGameTimeValues:(NSTimeInterval)gameTime {
    
    totalGameTime += gameTime;
    if ((completedGames > 0) && (gameTime > 0)) {
        avgGameTime = totalGameTime / (completedGames);
    }
    if ((gameTime > 0) && ((gameTime < bestGameTime) || (bestGameTime == 0))) {
        bestGameTime = gameTime;
    }
    
    // MME timingsScoreView.bestTimeValueLabel.text = [NSString stringWithFormat:@"%.2fs",bestGameTime];
    // MME timingsScoreView.averageTimeValueLabel.text = [NSString stringWithFormat:@"%.2fs",avgGameTime];
    
}

- (void) updateScoresForButtonState:(MBMButtonState)buttonState {
    
    // update hits
    // update misses
    // update game
    // update cancelled games
    // update bestTime
    // update avgTime
    // reset timer
    
}


- (void) revealMisses {
    for (MBMBubbleUIView *bview in bubbles) {
        if (!bview.bubbleIsHit) {
            [bview showAs:bubbleHit];
            bview.layer.zPosition = 300;
            [bview fadeBubbleType:bubbleHitFaded];
            
        }
    }
}

- (void) updateHitsInOrder {
    
    int i = 0, inOrder = 0;
    
    for (MBMBubbleUIView *bview in bubblesHit) {
        
        NSLog(@"bView.bubbleIndex : %d, i: %d", bview.bubbleIndex, i);
        
        if (bview.bubbleIndex == i) {
            NSLog(@"Not in order");
            inOrder++;
        }
        
        i++;
        
    }
    
    gameCounter.ordered = inOrder;
    
    // --MME hitsInOrderValue.text = [NSString stringWithFormat:@"%d", i];
    
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
   
    // [[self gameView] handleInterfaceRotation];

}

- (MBMGameMessageUIView *) gameMessageView {
    _gameMessageView.gameMessageValue = gameMessageValue;
    return _gameMessageView;
}

/*
- (void) scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}
*/

/*
- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    pageControlBeingUsed = YES;
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void) displayGameLevelScoresForCounter:(MBMCounter *)counter {
    
    for (MBMScoreView *view in gameLevelScoreViews) {
        [view displayScoresForCounter:counter];
    }
    
}

- (void) displaySessionLevelScoresForCounter:(MBMCounter *)counter {
    for (MBMScoreView *view in sessionLevelScoreViews) {
        [view displayScoresForCounter:counter];
    }
}

- (void) displayOverallLevelScoresForCounter:(MBMCounter *)counter {
    for (MBMScoreView *view in overallLevelScoreViews) {
        [view displayScoresForCounter:counter];
    }
}

- (void) displayElapsedTime:(NSTimeInterval)elapsedTime {
    for (MBMScoreView *view in scoreViews) {
        [view displayElapsedTime:elapsedTime];
    }
}

- (void) displayCurrentTime:(NSTimeInterval)currentTime {
    self.currentTimeValue.text = [NSString stringWithFormat:@"%.2fs", currentTime];
}

- (void) addBubblesWithAnimation:(BOOL)withAnimation {
    
    // calculate the offset of the first bubble, they should appear horizontally centered
    
    float firstBubbleOffset = ([self gameView].frame.size.width / 2) - (bubbles.count * ((MBMBubbleUIView *)[bubbles objectAtIndex:0]).gameFrame.size.width) / 2;
    
    for (MBMBubbleUIView *bview in bubbles) {

        // [[self gameView] addSubview:bview];
        [bview displayIndex];
        
        CGPoint flyToLocation = CGPointMake((bview.bubbleIndex) * bview.gameFrame.size.width + firstBubbleOffset, MBM_INITIAL_BUBBLE_LOCATION_Y);
        
        [bview flyInToLocation:flyToLocation withAnimation:YES fireCompleted:bview.isLastBubble];
        
        // flyInToLocation invokes flyInCompletedForBubbleView method in delegate
        
        // [bview moveToGameLocation:bview.gameLocation withAnimation:YES fireCompleted:NO];
        
    }
    
    
    // hideBubbleTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideTimerFires) userInfo:nil repeats:NO];
}

- (void) updateTimeInfo:(NSTimeInterval)time {
    [timeInfo updateCurrentTime:time];
}

- (void) updateTimeInfoDisplay:(MBMTimeInfo *)aTimeInfo {
    self.lastTimeValue.text = [NSString stringWithFormat:@"%.2fs", aTimeInfo.lastTimeDisplayValue];
    self.bestTimeValue.text = [NSString stringWithFormat:@"%.2fs", aTimeInfo.bestTimeDisplayValue];
    self.currentTimeValue.text = @"0s";
}

- (void) removeBubblesWithAnimation {
    
    CGFloat centerX = CGRectGetMidX([[self gameView] frame]);
    CGFloat centerY = CGRectGetMidY([[self gameView] frame]);
    
    // Draw line 
    
    NSLog(@"Center x: %f, y: %f", centerX, centerY);
    
    for (int i=0; i<bubblesMiss.count; i++) {
        MBMBubbleUIView *bubble = [bubblesMiss objectAtIndex:i];

        CGFloat cSide = centerX - bubble.frame.origin.x;
        CGFloat bSide = bubble.frame.origin.y - centerY;
        
        double aSide = sqrt(pow(bSide,2) + pow(cSide,2));
        
        double sinAlpha = asin(cSide/aSide) * 180/M_PI;
        
        NSLog(@"cSide: %f, aSide: %f -> Corner sinAlpha : %f", cSide, aSide, sinAlpha);
        
    }
}

#pragma Delegates

#pragma MBMBubbleUIViewDelegate

- (void)ignored___hideCompletedForBubbleView:(UIView *)view {
    
    // 21/04/2013 - while the bubbles are hiding a countdown counter (MBMCountingViewController) is shown.
    // When the countdown animation is finished, the view controller calls the countingAnimationCompleted
    // delegate method, this method will actually start the game
    
    // Game might have been cancelled, while buttons where executing animated hide

    // When the starView animation completes, the MBMStartViewDelegate method startViewAnimationCompleted:(MBMStartView *)startView is executed and
    // the timing of the game starts

    
    /*
     
    // Execute this piece of code when the MBMStartView needs give some start indication (green cross)
    CGRect startViewFrame = CGRectMake(0, 0, [self gameView].frame.size.width, [self gameView].frame.size.height);
    
    MBMStartView *startView = [[MBMStartView alloc] initWithFrame:startViewFrame];
    startView.delegate = self;
    
    
    [[self gameView] addSubview:startView];
    */
    
    // The startview is not used, so we call the delegate method directly
    [self startViewAnimationCompleted:nil];
    
    
    /*
    if ([[self controlButton] getButtonState] ==  buttonStateCancelGame) {
        [self timeGame];
        [self userInteractionAllowed:YES forView:[self gameView]];
    }
     */
}

- (void) flyInCompletedForBubbleView:(MBMBubbleUIView *)view {

    for (MBMBubbleUIView *bview in bubbles) {
        
        [[self gameView] addSubview:bview];
        [bview displayIndex];
                
        [bview moveToGameLocation:bview.gameLocation withAnimation:YES fireCompleted:bview.isLastBubble];
        
        [bview showShadowBubble:bubbleBlackWhite view:[self shadowView]];
        
        // moveToGameLocation invokes moveToGameLocationCompletedForBubbleView method in delegate
        
        
    }
    
}

- (void)moveToGameLocationCompletedForBubbleView:(MBMBubbleUIView *)view {
    hideBubbleTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideTimerFires) userInfo:nil repeats:NO];
}


#pragma MBMGameUIViewDelegate

- (void)processTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inGameView:(MBMGameUIView *) gameView {
    
    // We will only validate the first touch the see if there is a hit
    
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    
    bool isHit = NO;
        
    if ([self gameView].userInteractionEnabled) {
        
        for(MBMBubbleUIView *bubble in bubbles)
        {
            
            [bubble containsPoint:[touch locationInView:[self gameView]]];
            
            // First we test if we hit the png image of teh bubble, which is rectangular, however the buble is circular.
            // We need to check if the hit is also with the circle. Otherwise, if the user hits a point in de corners of the
            // rectangle, it looks as if the bubble shows up, even if there was no logical touch.
            
            // if ((CGRectContainsPoint([bubble frame], [touch locationInView:[self gameView]])) && (!bubble.bubbleIsHit)) {
            if ((!bubble.bubbleIsHit) && ([bubble containsPoint:[touch locationInView:[self gameView]]])) {
                NSLog(@"BubbleView is touched %d", bubble.bubbleIndex);
                bubble.bubbleIsHit = YES;
                bubble.timeSinceStart = currentGameTime;
                NSLog(@"bubble.timeSinceStart %.2f", bubble.timeSinceStart);
                [bubble showAs:bubbleHit];
                isHit = YES;
                [bubble bringToFront];
                
                [bubble showShadowBubble:bubbleNormal view:[self shadowView]];
                
                gameCounter.hits++;
                
                
                
                
                
                hits++;
                // MME totalsScoreView.hitsValueLabel.text = [NSString stringWithFormat:@"%d",hits];
                // currentGameHits++;
                
                
                
                // Calculate reaction time when hit
                
                if (bubblesHit.count == 0) {
                    gameCounter.bestReaction = currentGameTime;
                    gameCounter.lastReaction = gameCounter.bestReaction;
                }
                else {
                    // ((MBMBubbleUIView *)[bubblesHit lastObject]).timeSinceStart
                    gameCounter.lastReaction = currentGameTime - ((MBMBubbleUIView *)[bubblesHit lastObject]).timeSinceStart;
                    if (gameCounter.lastReaction < gameCounter.bestReaction) {
                        gameCounter.bestReaction = gameCounter.lastReaction;
                    }
                }
                
                [bubblesHit addObject:bubble];
                
                [self updateHitsInOrder];
                
                if (bubblesHit.count == (nbrOfBubbles)) {
                    [self completeGame];
                }
                
                break;
            }
            
        }
        
        if (!isHit) {
            
            // None of the bubbles is touched
            
            NSLog(@"BubbleView is Missed");
            
            CGPoint location = CGPointMake([touch locationInView:[self gameView]].x -20.0, [touch locationInView:[self gameView]].y - 20.0);
            
            MBMBubbleUIView *bview = [self addBubbleWithIndex:0 withBubbleType:bubbleMiss atLocation:location];
            [[self gameView] addSubview:bview];
            
            
            [bview fadeBubbleType:bubbleMissFaded];
            
            [bubblesMiss addObject:bview];
            
            gameCounter.misses++;
            
            misses++;
            // MME totalsScoreView.missesValueLabel.text = [NSString stringWithFormat:@"%d",misses];
            currentGameMisses++;
            
        }
        
    }
    else {
        NSLog(@"gameView interaction is not allowed");
        
       
    }
    
    [self displayGameLevelScoresForCounter:gameCounter];

    
}


#pragma MBMGameMessageUIViewDelegate

- (void)showGameStatistics {
    NSLog(@"About to show gameStatistics");
    
    MBMGameStatisticsViewController *statisticsViewController = [[MBMGameStatisticsViewController alloc] initWithNibName:nil bundle:nil];
        
    statisticsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:statisticsViewController animated:YES completion:nil];
    
}

#pragma MBMStarViewDelegate

- (void) startViewAnimationCompleted:(MBMStartView *)startView {
    
    [startView removeFromSuperview];
    startView = nil;
    
    if ([[self controlButton] getButtonState] ==  buttonStateCancelGame) {
        [self timeGame];
        [self userInteractionAllowed:YES forView:[self gameView]];
    }

}

#pragma MBMCountingViewControllerDelegate 

- (void) countingAnimationCompleted {
    
    [countingViewController.view removeFromSuperview];
    [countingViewController removeFromParentViewController];
    
    [self startViewAnimationCompleted:nil];
    
}

@end
