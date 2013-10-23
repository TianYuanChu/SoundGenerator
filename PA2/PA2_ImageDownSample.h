//
//  PA2_ImageDownSample.h
//  PA2
//
//  Created by Ryan Chu on 2013-10-22.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//  Copyright (c) 2013 Prince from Stackoverflow
//

#import <Foundation/Foundation.h>

@interface PA2_ImageDownSample : NSObject

+ (NSImage *)imageDownSample:(NSImage*)anImage newSize:(NSSize)newSize;

@end
