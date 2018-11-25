//
//  MBMTouchesScoreView.h
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMCounter.h"
#import "MBMScoreView.h"

@interface MBMTouchesScoreView : MBMScoreView {
    UILabel *bestTimeValueLabel;
    UILabel *hitsValueLabel;
    UILabel *missesValueLabel;
    UILabel *titleLabel;
    UILabel *orderedValueLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *hitsValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *missesValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *orderedValueLabel;


@end
