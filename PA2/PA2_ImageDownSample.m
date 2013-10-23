//
//  PA2_ImageDownSample.m
//  PA2
//
//  Created by Ryan Chu on 2013-10-22.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//  Copyright (c) 2013 Prince from Stackoverflow
//

#import "PA2_ImageDownSample.h"

@implementation PA2_ImageDownSample

+ (NSImage *)imageDownSample:(NSImage*)anImage newSize:(NSSize)newSize {
    NSImage *sourceImage = anImage;
    [sourceImage setScalesWhenResized:YES];
    
    if (![sourceImage isValid])
    {
        NSLog(@"Invalid Image");
    } else
    {
        NSImage *smallImage = [[NSImage alloc] initWithSize: newSize];
        [smallImage lockFocus];
        [sourceImage setSize: newSize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositeCopy fraction:1.0];
        [smallImage unlockFocus];
        return smallImage;
    }
    return nil;
}

@end
