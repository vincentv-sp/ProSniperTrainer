//
//  RateView.h
//  CustomView
//
//  Created by Ray Wenderlich on 7/30/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeterView;

@interface MeterView : UIView {
    UIImage *_blankBar;
    UIImage *_greenBar;
    UIImage *_yellowBar;
    UIImage *_redBar;
    float _rating;
    BOOL _editable;
    NSMutableArray *_imageViews;
    int _maxRating;
    int _midMargin;
    int _leftMargin;
    CGSize _minImageSize;
}

@property (retain) UIImage *blankBar;
@property (retain) UIImage *greenBar;
@property (retain) UIImage *yellowBar;
@property (retain) UIImage *redBar;
@property  float rating;
@property  BOOL editable;
@property  int maxRating;
@property  int leftMargin;

@end