//
//  UIView+Parallax.m
//  S31Kit
//
//  Created by Section 31 on 05/04/2014.
//  Copyright (c) 2014 Section 31 Pte. Ltd. All rights reserved.
//

#import "UIView+Parallax.h"

@implementation UIView (Parallax)

// Add Parallax to multiple views
+ (void)addHorizontalParallaxToViews:(NSArray *)views
{
    for (id obj in views) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIInterpolatingMotionEffect *horizontalMotionEffect =
            [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            horizontalMotionEffect.minimumRelativeValue = @(-5);
            horizontalMotionEffect.maximumRelativeValue = @(5);
            
            [obj addMotionEffect:horizontalMotionEffect];
        }
    }
}

+ (void)addVerticalParralaxToViews:(NSArray *)views
{
    for (id obj in views) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIInterpolatingMotionEffect *verticalMotionEffect =
            [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            verticalMotionEffect.minimumRelativeValue = @(-5);
            verticalMotionEffect.maximumRelativeValue = @(5);
            
            [obj addMotionEffect:verticalMotionEffect];
        }
    }

}

// Add Parallax to one view
+ (void)addHorizontalParallaxToView:(UIView *)view
{
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-5);
    horizontalMotionEffect.maximumRelativeValue = @(5);
    
    [view addMotionEffect:horizontalMotionEffect];
}

+ (void)addVerticalParralaxToView:(UIView *)view
{
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-5);
    verticalMotionEffect.maximumRelativeValue = @(5);
    
    [view addMotionEffect:verticalMotionEffect];
}


@end
