//
//  UIImage+Comparison.m
//  S31Kit
//
//  Created by Section 31 on 06/04/2014.
//  Copyright (c) 2014 Section 31 Pte. Ltd. All rights reserved.
//

#import "UIImage+Comparison.h"

typedef NS_ENUM(NSUInteger, ImageComparison) {
    ImagesAreNotTheSame,
    ImagesAreTheSame,
};

@implementation UIImage (Comparison)

/**
 *  This method takes two UIImages and compares them by looking at their respective JPEG data.
 *
 *  @param image1 First UIImage to compare.
 *  @param image2 Second UIImage to compare.
 *
 *  @return BOOL YES/NO based on match/no-match.
 */
+ (BOOL)isImageOne:(UIImage *)image1 theSameAsImageTwo:(UIImage *)image2
{
    NSData *dataFromImage1 = UIImageJPEGRepresentation(image1, 0.0);
    NSData *dataFromImage2 = UIImageJPEGRepresentation(image2, 0.0);
    
    if ([dataFromImage1 isEqualToData:dataFromImage2]) {
        return ImagesAreTheSame;
    } else
    {
        return ImagesAreNotTheSame;
    }
}

@end