//
//  PA2_ImageGrayConvert.h
//  PA2
//
//  Created by Ryan Chu on 2013-10-22.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CoreImage.h>

@interface PA2_ImageGrayConvert : NSObject

//jpg only
+ (NSImage *)Color2GrayScaleConvert:(NSImage *)srcImage;

//second approach std
+ (NSImage *)Color2GrayScaleWithCustomeFilter:(NSImage *)srcImage;
@end
