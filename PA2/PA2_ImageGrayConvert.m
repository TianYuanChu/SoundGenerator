//
//  PA2_ImageGrayConvert.m
//  PA2
//
//  Created by Ryan Chu on 2013-10-22.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//  Copyright (c) Peter Ammon <email@hidden>
//

#import "PA2_ImageGrayConvert.h"

@implementation PA2_ImageGrayConvert

+ (NSImage *)Color2GrayScaleConvert:(NSImage *)srcImage
{
    NSBitmapImageRep *srcImageRep = [NSBitmapImageRep
                                     imageRepWithData:[srcImage TIFFRepresentation]];
    NSImage *destImage = [[NSImage alloc] initWithSize:[srcImage size]];
    
    NSInteger w = [srcImageRep pixelsWide];
    NSInteger h = [srcImageRep pixelsHigh];
    long x, y;
    const BOOL hasAlpha=[srcImageRep hasAlpha];
    
    NSBitmapImageRep *destImageRep = [[NSBitmapImageRep alloc]
                                       initWithBitmapDataPlanes:NULL
                                       pixelsWide:w
                                       pixelsHigh:h
                                       bitsPerSample:8
                                       samplesPerPixel:hasAlpha ? 2 : 1
                                       hasAlpha: hasAlpha
                                       isPlanar:NO
                                       colorSpaceName:NSCalibratedWhiteColorSpace
                                       bytesPerRow:0
                                       bitsPerPixel:0];
    
    unsigned char *srcData = [srcImageRep bitmapData];
    unsigned char *destData = [destImageRep bitmapData];
    unsigned char *p1, *p2;
    NSInteger n = [srcImageRep bitsPerPixel] / 8;
    
    int height = [srcImage size].height;
    int width = [srcImage size].width;
    
    for ( y = 0; y < height; y++ ) {
        for ( x = 0; x < width; x++ ) {
            p1 = srcData + n * (y * w + x);
            p2 = destData + y * w + x;
            //NTSC std: .299, .587, .114
            p2[0] = (unsigned char)rint(0.299*p1[0] + 0.587*p1[1] + 0.114*p1[2]);
        }
    }
    
    [destImage addRepresentation:destImageRep];
    return destImage;
}

+ (NSImage *)Color2GrayScaleWithCustomeFilter:(NSImage *)srcImage
{
    NSBitmapImageRep *srcImageRep = [NSBitmapImageRep
                                     imageRepWithData:[srcImage TIFFRepresentation]];
    NSInteger w = [srcImageRep pixelsWide];
    NSInteger h = [srcImageRep pixelsHigh];
    const BOOL hasAlpha=[srcImageRep hasAlpha];
    
    NSBitmapImageRep *destImageRep = [[NSBitmapImageRep alloc]
                                      initWithBitmapDataPlanes:NULL
                                      pixelsWide:w
                                      pixelsHigh:h
                                      bitsPerSample:8
                                      samplesPerPixel:hasAlpha ? 2 : 1
                                      hasAlpha: hasAlpha
                                      isPlanar:NO
                                      colorSpaceName:NSCalibratedWhiteColorSpace
                                      bytesPerRow:0
                                      bitsPerPixel:0];
    //NSImage to CIImage
    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [monochromeFilter setDefaults];
    [monochromeFilter setValue:[CIImage imageWithData:[srcImage TIFFRepresentation]] forKey:@"inputImage"];
    [monochromeFilter setValue:[CIColor colorWithRed:0 green:0 blue:0 alpha:0.5] forKey:@"inputColor"];
    [monochromeFilter setValue:[NSNumber numberWithFloat:1] forKey:@"inputIntensity"];
    
    CIImage *output = (CIImage *)[monochromeFilter valueForKey:kCIOutputImageKey];
    
    //CIImage to NSImagea
    CIContext *context = [CIContext contextWithCGContext:nil options:nil];
    CGImageRef cgiimage = [context createCGImage:output fromRect:[output extent]];
    NSImage* newImage = [[NSImage alloc] initWithCGImage:cgiimage size:[srcImage size]];
    
    CGImageRelease(cgiimage);
    [newImage addRepresentation:destImageRep];
    return newImage;
}
@end
