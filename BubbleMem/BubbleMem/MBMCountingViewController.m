//
//  MBMCountingViewController.m
//  BubbleMem
//
//  Created by Marc Meewis on 20/04/13.
//  Copyright (c) 2013 Marc Meewis. All rights reserved.
//

#import "MBMCountingViewController.h"


@interface MBMCountingViewController ()

@end

@implementation MBMCountingViewController {
    UIImageView *one, *two, *three;
    NSMutableArray *counter;
}

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self createImageViews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createImageViews {
    one = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"one.png"]];
    two = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"two.png"]];
    three = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"three.png"]];
    
    counter = [[NSMutableArray alloc] initWithCapacity:3];
    
    [counter addObject:one];
    [counter addObject:two];
    [counter addObject:three];
    
}

- (void) count:(MBMCountDirection)direction animationDuration:(NSTimeInterval)duration {
    
    CGPoint center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /2);
    
    switch (direction) {
        case up:
            [self showValue:1 forDirection:direction centerPoint:center animationDuration:duration/counter.count];
            break;
        case down:
            [self showValue:3 forDirection:direction centerPoint:center animationDuration:duration/counter.count];
        default:
            break;
    }
    
}

- (void) showValue:(NSInteger)value forDirection:(MBMCountDirection)direction centerPoint:(CGPoint)center animationDuration:(NSTimeInterval)duration {
    
    UIView *countValueView = [counter objectAtIndex:(value -1)];
    CGRect fromFrame = CGRectMake(center.x - (MBM_COUNTERVALUE_VIEW_START_SIZE /2), center.y - (MBM_COUNTERVALUE_VIEW_START_SIZE /2), MBM_COUNTERVALUE_VIEW_START_SIZE, MBM_COUNTERVALUE_VIEW_START_SIZE);

    CGRect toFrame = CGRectMake(center.x - (MBM_COUNTERVALUE_VIEW_END_SIZE /2), center.y - (MBM_COUNTERVALUE_VIEW_END_SIZE /2), MBM_COUNTERVALUE_VIEW_END_SIZE, MBM_COUNTERVALUE_VIEW_END_SIZE);

    countValueView.frame = fromFrame;
    
    [self.view addSubview:countValueView];
    
    
    [UIView animateWithDuration:duration animations:^{
        countValueView.frame = toFrame;
    } completion: ^(BOOL finished) {
        
        [countValueView removeFromSuperview];
        
        __block NSInteger blokValue = value;
        
        if ((direction == up) && (value <= 3)) {
            blokValue++;
            [self showValue:blokValue forDirection:direction centerPoint:center animationDuration:duration];
        }
        else if ((direction == down) && (value > 1)) {
            blokValue--;
            [self showValue:blokValue forDirection:direction centerPoint:center animationDuration:duration];
        }
        else {
            if ([delegate respondsToSelector:@selector(countingAnimationCompleted)]) {
                [delegate countingAnimationCompleted];
            }
        }
        
    }];
    
        
}

@end
