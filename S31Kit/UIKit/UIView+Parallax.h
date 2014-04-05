//
//  UIView+Parallax.h
//  S31Kit
//
//  Created by Section 31 on 05/04/2014.
//  Copyright (c) 2014 Section 31 Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Parallax)

// Add Parallax to multiple views
+ (void)addHorizontalParallaxToViews:(NSArray *)views;
+ (void)addVerticalParralaxToViews:(NSArray *)views;

// Add Parallax to one view
+ (void)addHorizontalParallaxToView:(UIView *)view;
+ (void)addVerticalParralaxToView:(UIView *)view;

@end
