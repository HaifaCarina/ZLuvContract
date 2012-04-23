//
//  FrameViewController.h
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/13/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "GlobalData.h"

@interface FrameViewController : UIViewController <FBSessionDelegate, FBRequestDelegate, UIScrollViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    int selectedTag;
    UIImage *selectedTemplate;
    
    UIImageView *photoView1;
    UIImageView *photoView2;
    UIView *contentView1;
    UIView *contentView2;
    UIScrollView *scrollview1;
    UIScrollView *scrollview2;
    CGRect scrollviewRect1;
    CGRect scrollviewRect2;
    
    UIImagePickerController *imgPicker;
    int currentPhotoTag;
    
}
@property (nonatomic) int selectedTag;
@property (nonatomic, retain) UIImage *selectedTemplate;


- (id) initWithTemplate:(UIImage *)templateImage tag: (int)tag;

@end
