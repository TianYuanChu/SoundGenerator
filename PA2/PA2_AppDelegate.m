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
        NSImage *newImage = [PA2_ImageGrayConvert grayscale:loadedImage];

        
        NSBitmapImageRep *imgRep = [[newImage representations] objectAtIndex: 0];
        NSData *data = [imgRep representationUsingType: NSPNGFileType properties: nil];
        NSString *docsDir;
        NSArray *dirPaths;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"foo.tiff"]];
        [data writeToFile:databasePath atomically:NO];
    }
}

- (IBAction)openFolder:(id)sender {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folderURL = [dirPaths objectAtIndex:0];
    NSURL *fileURL = [NSURL fileURLWithPath: folderURL];
    [[NSWorkspace sharedWorkspace] openURL: fileURL];
}

@end
