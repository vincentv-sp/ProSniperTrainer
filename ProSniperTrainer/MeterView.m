//
//  RateView.m
//  CustomView
//
//  Created by Ray Wenderlich on 7/30/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "MeterView.h"

@implementation MeterView
@synthesize blankBar = _blankBar;
@synthesize rating = _rating;
@synthesize editable = _editable;
@synthesize maxRating = _maxRating;
@synthesize leftMargin = _leftMargin;
@synthesize greenBar = _greenBar;
@synthesize yellowBar = _yellowBar;
@synthesize redBar = _redBar;

#pragma mark Main
- (void)baseInit {
    _imageViews = [[NSMutableArray array] retain];
    _blankBar = nil;
    _greenBar = nil;
    _yellowBar = nil;
    _redBar = nil;
    _rating = 0;
    _editable = NO;
    _maxRating = 0;
    _leftMargin = 0;
    _midMargin = 0;        
    _minImageSize = CGSizeMake(5, 5);        
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];        
    }
    return self;
}

- (void)dealloc {
    [_blankBar release];
    _blankBar = nil;
    [_greenBar release];
    _greenBar = nil;
    [_yellowBar release];
    _yellowBar = nil;
    [_redBar release];
    _redBar = nil;
    [_imageViews release];
    _imageViews = nil;
    [super dealloc];
}

#pragma mark Refresh + ReLayout

- (void)refresh {
    for(int i = 0; i < _imageViews.count; ++i) {
        UIImageView *imageView = [_imageViews objectAtIndex:i];
        if ((_rating >= i+1) && (i <= 3)) {
            imageView.image = _greenBar;
        }else if ((_rating >= i+1) && (i <= 7)) {
            imageView.image = _yellowBar;
        }else if ((_rating >= i+1) && (i <= 12)) {
            imageView.image = _redBar;
        } else if ((_rating > i) && (i <=3)) {
            imageView.image = _greenBar;
        } else if ((_rating > i) && (i <=7)) {
            imageView.image = _yellowBar;
        } else if ((_rating > i) && (i <=12)) {
            imageView.image = _redBar;
        } else {
            imageView.image = _blankBar;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_blankBar == nil) return;
    
    NSLog(@"%f, %d, %d, %d", self.frame.size.width, _leftMargin, _midMargin, _imageViews.count);
    float desiredImageWidth = (self.frame.size.width - (_leftMargin*2) - (_midMargin*_imageViews.count)) / _imageViews.count;
    float imageWidth = MAX(_minImageSize.width, desiredImageWidth);
    float imageHeight = MAX(_minImageSize.height, self.frame.size.height);
    
    for (int i = 0; i < _imageViews.count; ++i) {
        
        UIImageView *imageView = [_imageViews objectAtIndex:i];
        CGRect imageFrame = CGRectMake(_leftMargin + i*(_midMargin+imageWidth), 0, imageWidth, imageHeight);
        imageView.frame = imageFrame;
        
    }    
    
}

#pragma mark Setting Properties

- (void)setMaxRating:(int)maxRating {
    _maxRating = maxRating;
    
    // Remove old image views
    for(int i = 0; i < _imageViews.count; ++i) {
        UIImageView *imageView = (UIImageView *) [_imageViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [_imageViews removeAllObjects];
    
    // Add new image views
    for(int i = 0; i < maxRating; ++i) {
        UIImageView *imageView = [[[UIImageView alloc] init] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    
    // Relayout and refresh
    [self setNeedsLayout];
    [self refresh];
}

- (void)setBlankBar:(UIImage *)image {
    [_blankBar release];
    _blankBar = [image retain];
    [self refresh];
}

- (void)setGreenBar:(UIImage *)image {
    [_greenBar release];
    _greenBar = [image retain];
    [self refresh];
}

- (void)setYellowBar:(UIImage *)image {
    [_yellowBar release];
    _yellowBar = [image retain];
    [self refresh];
}

- (void)setRedBar:(UIImage *)image {
    [_redBar release];
    _redBar = [image retain];
    [self refresh];
}

- (void)setRating:(float)rating {
    _rating = rating;
    [self refresh];
}
/*
#pragma mark Touch detection

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    if (!_editable) return;
    
    _rating = 0;
    for(int i = _imageViews.count - 1; i >= 0; i--) {
        UIImageView *imageView = [_imageViews objectAtIndex:i];        
        if (touchLocation.x > imageView.frame.origin.x) {
            _rating = i+1;
            break;
        }
    }
    
    [self refresh];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate rateView:self ratingDidChange:_rating];
}
*/
@end
