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

+ (NSImage*)grayscale:(NSImage*)colorImage {
    //NTSC standard
    const double conversionWeights[3]={.299, .587, .114};
    NSArray* currentReps=[colorImage representations];
    NSData* tiffData=[NSBitmapImageRep TIFFRepresentationOfImageRepsInArray:currentReps
                                                           usingCompression:NSTIFFCompressionNone
                                                                     factor:0.0];
    NSBitmapImageRep* bitmap=[NSBitmapImageRep imageRepWithData:tiffData];
    //we don't know how to handle anything but CHAR_BIT bits per sample
    NSAssert1([bitmap bitsPerSample]==CHAR_BIT, @"bitsPerSample is %ld in grayscale method", [bitmap bitsPerSample]);
    unsigned char* planes[5];
    [bitmap getBitmapDataPlanes:planes];
    int numberPlanes=0;
    while (numberPlanes < 5 && planes[numberPlanes]) numberPlanes++;
    const BOOL hasAlpha=[bitmap hasAlpha];
    const long samples=[bitmap samplesPerPixel];
    NSBitmapImageRep* grayBitmap=[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil pixelsWide:[bitmap pixelsWide] pixelsHigh:[bitmap pixelsHigh] bitsPerSample:8 samplesPerPixel: hasAlpha ? 2 : 1 hasAlpha: hasAlpha isPlanar:YES colorSpaceName:NSCalibratedWhiteColorSpace bytesPerRow:0 bitsPerPixel:0];
    

    if (! grayBitmap) return nil;

    unsigned char* destDataPlanes[2];
    [grayBitmap getBitmapDataPlanes:destDataPlanes];
    unsigned char* grayData=destDataPlanes[0];
    unsigned char* alphaData=destDataPlanes[1];
    if (! [bitmap isPlanar]) {
        long height, maxHeight=[bitmap pixelsHigh], bytesPerRow=[bitmap bytesPerRow], rowLength=[bitmap pixelsWide]*samples;
        unsigned char* writer=grayData;
        unsigned char* alpha=alphaData;
        for (height=0; height<maxHeight; height++) {
            unsigned char* start=planes[0]+height*bytesPerRow;
            unsigned char* pos=start;
            while (pos-start < rowLength) {
                long sampleCounter=samples;
                double average=0;
                if (sampleCounter==3 || (sampleCounter==4 && hasAlpha)) {
                    average+=conversionWeights[0]**pos++;
                    average+=conversionWeights[1]**pos++;
                    average+=conversionWeights[2]**pos++;
                    if (hasAlpha) *alpha++=*pos++;
                    *writer++=(unsigned char)average;
                }
                else {
                    if (hasAlpha) {
                        while (--sampleCounter) average+=*pos++;
                        *writer++=(unsigned char)(average/(samples-1));
                        *alpha++=*pos++;
                    }
                    else {
                        while (sampleCounter--) average+=*pos++;
                        *writer++=(unsigned char)(average/samples);
                    }
                }
            }
        }
    }
    else { //bitmap is planar
        long height, maxHeight=[bitmap pixelsHigh], bytesPerRow=[bitmap bytesPerRow], rowLength=[bitmap pixelsWide]*samples;
        unsigned char* writer=grayData;
        unsigned char* alpha=alphaData;
        for (height=0; height<maxHeight; height++) {
            long offset=height*bytesPerRow;
            int i;
            for (i=0; i<rowLength; i++) {
                long sampleCounter=samples;
                double average=0;
                if (sampleCounter==3 || (sampleCounter==4 && hasAlpha)) {
                    average+=conversionWeights[0]*planes[0][i+offset];
                    average+=conversionWeights[1]*planes[1][i+offset];
                    average+=conversionWeights[2]*planes[2][i+offset];
                    if (hasAlpha) *alpha++=planes[3][i+offset];
                    *writer++=(unsigned char)average;
                }
                else {
                    if (hasAlpha) {
                        *alpha++=planes[--sampleCounter][i+offset];
                        while (sampleCounter--) average+=planes[sampleCounter][i+offset];
                        *writer++=(unsigned char)(average/(samples-1));
                    }
                    else {
                        while (sampleCounter--) average+=planes[sampleCounter][i+offset];
                        *writer++=(unsigned char)(average/samples);
                    }
                }
            }
        }
    }
    //quick hack/fix on autorelease issue
    NSBitmapImageRep* grayBitmapBak=[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil pixelsWide:[bitmap pixelsWide] pixelsHigh:[bitmap pixelsHigh] bitsPerSample:8 samplesPerPixel: hasAlpha ? 2 : 1 hasAlpha: hasAlpha isPlanar:YES colorSpaceName:NSCalibratedWhiteColorSpace bytesPerRow:0 bitsPerPixel:0];
    NSImage* newImage=[[NSImage alloc] initWithSize:[colorImage size]];
    [newImage addRepresentation:grayBitmapBak];
    return newImage;
}

@end
