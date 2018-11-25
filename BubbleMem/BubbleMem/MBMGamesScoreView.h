//
//  MBMTotalsScoreView.h
//  BubbleMem
//
//  Created by Marc Meewis on 23/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMCounter.h"
#import "MBMScoreView.h"

@interface MBMGamesScoreView : MBMScoreView {
    UILabel *completedValueLabel;
    UILabel *cancelledValueLabel;
    UILabel *timeValueLabel;
    UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *cancelledValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *completedValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeValueLabel;


@end
