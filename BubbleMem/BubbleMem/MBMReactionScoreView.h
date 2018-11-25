//
//  MBMReactionScoreView.h
//  BubbleMem
//
//  Created by Marc Meewis on 24/03/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMCounter.h"
#import "MBMScoreView.h"

@interface MBMReactionScoreView : MBMScoreView {
    UILabel *timeValueLabel;
    UILabel *bestReactionValueLabel;
    UILabel *averageReactionValueLabel;
    UILabel *lastReactionValueLabel;
    UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *bestReactionValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *averageReactionValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastReactionValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeValueLabel;


@end
