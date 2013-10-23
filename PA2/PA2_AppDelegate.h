//
//  PA2_AppDelegate.h
//  PA2
//
//  Created by Ryan Chu on 2013-10-15.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PA2_AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSImageCell *imageView;
@property (weak) IBOutlet NSTextField *picInfo;
@property (weak) IBOutlet NSButtonCell *convertGrayBtn;
@property (weak) IBOutlet NSButton *downSampleBtn;


- (IBAction)Convert2Gray:(id)sender;
- (IBAction)OpenFolder:(id)sender;
- (IBAction)DownSample:(id)sender;


@end
