//
//  FrameViewController.h
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/13/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FrameViewController : UIViewController {
    int selectedTag;
    UIImage *selectedTemplate;
    CGRect scrollviewRect1;
    CGRect scrollviewRect2;
}
@property (nonatomic) int selectedTag;
@property (nonatomic, retain) UIImage *selectedTemplate;

- (id) initWithTemplate:(UIImage *)templateImage tag: (int)tag;

@end
