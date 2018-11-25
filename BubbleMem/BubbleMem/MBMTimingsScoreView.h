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

@interface MBMTimingsScoreView : MBMScoreView {
    UILabel *bestTimeValueLabel;
    UILabel *averageTimeValueLabel;
    UILabel *timeValueLabel;
    UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *bestTimeValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *averageTimeValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeValueLabel;


@end
