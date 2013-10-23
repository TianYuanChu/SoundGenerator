//
//  PA2_AppDelegate.m
//  PA2
//
//  Created by Ryan Chu on 2013-10-15.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//

#import "PA2_AppDelegate.h"
#import "PA2_ImageGrayConvert.h"
#import "PA2_ImageDownSample.h"

#define NOT_AVAILABLE @"Image is not currently loaded.."
@implementation PA2_AppDelegate
@synthesize imageView, picInfo, convertGrayBtn, downSampleBtn;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[picInfo cell] setPlaceholderString:NOT_AVAILABLE];
    if ([[[picInfo cell]placeholderString] isEqualToString:NOT_AVAILABLE]) {
        [downSampleBtn setEnabled:NO];
    }
}

- (IBAction)Convert2Gray:(id)sender {
    if ([imageView objectValue]==nil)
    {
        [[picInfo cell] setPlaceholderString:NOT_AVAILABLE];
    }
    else
    {
        
        NSImage *loadedImage = [imageView image];
        [[picInfo cell] setPlaceholderString:[NSString stringWithFormat:@"Original Size: %d X %d",(int)[loadedImage size].width,(int)[loadedImage size].height]];
        NSImage *newImage = [PA2_ImageGrayConvert Color2GrayScaleWithCustomeFilter:loadedImage];
         
        [self SaveTempImage:newImage WithName:@"temp_grayScale"];
        
        [imageView setImage:newImage];
        [downSampleBtn setEnabled:YES];
    }
}

- (IBAction)OpenFolder:(id)sender {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderURL = [NSString stringWithFormat:@"%@/CMPT365/srcImage",[dirPaths objectAtIndex:0]];
    NSLog(@"%@",folderURL);
    NSURL *fileURL = [NSURL fileURLWithPath: folderURL];
    [[NSWorkspace sharedWorkspace] openURL: fileURL];
}

- (IBAction)DownSample:(id)sender {
    NSImage* newImage = [PA2_ImageDownSample imageDownSample:[imageView image] newSize:NSMakeSize(64.0, 64.0)];
    [self SaveTempImage:newImage WithName:@"temp_downSample"];
    [imageView setImage:newImage];
    [[picInfo cell] setPlaceholderString:@"Downsample Complete!"];
}

- (NSData *) PNGRepresentationOfImage:(NSImage *) image {
    // Create a bitmap representation from the current image
    [image lockFocus];
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc]initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width,image.size.height)];
    [image unlockFocus];
    
    return [bitmapRep representationUsingType:NSPNGFileType properties:Nil];
}

-(void)SaveTempImage:(NSImage*)image WithName:(NSString*)fileName
{
    NSString *completeFileName = [NSString stringWithFormat:@"%@_%f.png",fileName,[[NSDate date]timeIntervalSince1970]];
    NSData *data = [self PNGRepresentationOfImage:image];
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [NSString stringWithFormat:@"%@/CMPT365/destImage",[dirPaths objectAtIndex:0]];
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:completeFileName]];
    [data writeToFile:databasePath atomically:NO];
}

@end
