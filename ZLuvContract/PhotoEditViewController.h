//
//  PhotoEditViewController.h
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/23/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GlobalData.h"
@interface PhotoEditViewController : UIViewController <UIScrollViewDelegate>{
    UIScrollView *filtersScrollView;
    UIScrollView *stickersScrollView;
    
    UIScrollView *imageScrollView;
    UIView *contentView; 
    
    
}

@end
