//
//  MBMViewController.h
//  BubbleMem
//
//  Created by Marc Meewis on 10/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMBubbleUIView.h"
#import "MBMGameMessageUIView.h"
#import "MBMGameUIView.h"
#import "MBMStartView.h"
#import "MBMCountingViewController.h"

typedef enum {UIViewOverallTimings = 0, UIViewSessionTimings = 1, UIViewOverallTouches = 2, UIViewSessionTouches = 3, UIViewGameTouches = 4, UIViewOverallReaction = 5, UIViewSessionReaction = 6, UIViewGameReaction = 7, UIViewOverallGames = 8, UIViewSessionGames = 9} MBMScoreViewType;

@interface MBMViewController : UIViewController <MBMBubbleUIViewDelegate, MBMGameUIViewDelegate,
                                                    MBMGameMessageUIViewDelegate, MBMStarViewDelegate, MBMCountingViewControllerDelegate, UIScrollViewDelegate> {

    /*
    IBOutlet UILabel *hitsValue;
    IBOutlet UILabel *missesValue;
    IBOutlet UILabel *timeInfoValue;
    IBOutlet UILabel *completedGamesValue;
    IBOutlet UILabel *cancelledGamesValue;
    IBOutlet UILabel *bestGameTimeValue;
    IBOutlet UILabel *avgGameTimeValue;
    IBOutlet UILabel *gameMessageValue;
    IBOutlet UILabel *hitsInOrderValue;
    */

    UIScrollView *scrollView;
    UIPageControl *pageControl;
                                                    
    MBMGameMessageUIView  *_gameMessageView;
}

/*
@property (nonatomic, retain) IBOutlet UILabel *hitsValue;
@property (nonatomic, retain) IBOutlet UILabel *missesValue;
@property (nonatomic, retain) IBOutlet UILabel *timeInfoValue;
@property (nonatomic, retain) IBOutlet UILabel *completedGamesValue;
@property (nonatomic, retain) IBOutlet UILabel *cancelledGamesValue;
@property (nonatomic, retain) IBOutlet UILabel *bestGameTimeValue;
@property (nonatomic, retain) IBOutlet UILabel *avgGameTimeValue;
@property (nonatomic, retain) IBOutlet UILabel *hitsInOrderValue;
*/

// Score Views

// @property (nonatomic, retain) IBOutlet MBMTotalsScoreView *totalScoreView;
// @property (nonatomic, retain) IBOutlet MBMTimingsScoreView *timingsScoreView;

@property (nonatomic, retain) IBOutlet UILabel *gameMessageValue;

@property (nonatomic, retain) IBOutlet UIView *timingPlaceHolderView;

@property (nonatomic, retain) IBOutlet MBMGameMessageUIView  *gameMessageView;
// @property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
// @property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

@property (weak, nonatomic) IBOutlet UILabel *bestTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeValue;


// - (IBAction)changePage;

@end
