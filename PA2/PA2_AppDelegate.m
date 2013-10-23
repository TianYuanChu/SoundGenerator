//
//  PA2_AppDelegate.m
//  PA2
//
//  Created by Ryan Chu on 2013-10-15.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//

#import "PA2_AppDelegate.h"
#import "PA2_ImageGrayConvert.h"

@implementation PA2_AppDelegate
@synthesize imageView, picInfo, convertGrayBtn;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
}

- (IBAction)Convert2Gray:(id)sender {
    if ([imageView objectValue]==nil)
    {
        [[picInfo cell] setPlaceholderString:@"Image is not currently loaded.."];
    }
    else
    {
        NSImage *loadedImage = [imageView image];
        NSImage *newImage = [PA2_ImageGrayConvert Color2GrayScaleWithCustomeFilter:loadedImage];
               
        NSData *data = [self PNGRepresentationOfImage:newImage];
        NSString *docsDir;
        NSArray *dirPaths;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"foo.png"]];
        [data writeToFile:databasePath atomically:NO];
    }
}

- (IBAction)openFolder:(id)sender {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderURL = [dirPaths objectAtIndex:0];
    NSURL *fileURL = [NSURL fileURLWithPath: folderURL];
    [[NSWorkspace sharedWorkspace] openURL: fileURL];
}
- (NSData *) PNGRepresentationOfImage:(NSImage *) image {
    // Create a bitmap representation from the current image
    [image lockFocus];
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc]initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width,image.size.height)];
    [image unlockFocus];
    
    return [bitmapRep representationUsingType:NSPNGFileType properties:Nil];
}

@end
