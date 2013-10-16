//
//  PA2_DragAndDropView.h
//  PA2
//
//  Created by Ryan Chu on 2013-10-15.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//  Copyright (C) 2011 Apple Inc. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface PA2_DragAndDropView : NSImageView <NSDraggingSource, NSDraggingDestination, NSPasteboardItemDataProvider>
{
    //highlight the drop zone
    BOOL highlight;
}

- (id)initWithCoder:(NSCoder *)coder;

@end
