//
//  PA2_ToneGenerator.h
//  PA2
//
//  Created by Ryan Chu on 2013-10-22.
//  Copyright (c) 2013 Ryan Chu. All rights reserved.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>

OSStatus RenderTone(
                    void *inRefCon,
                    AudioUnitRenderActionFlags  *ioActionFlags,
                    const AudioTimeStamp        *inTimeStamp,
                    UInt32                      inBusNumber,
                    UInt32                      inNumberFrames,
                    AudioBufferList             *ioData);
void ToneInterruptionListener(void *inClientData, UInt32 inInterruptionState);

@interface PA2_ToneGenerator : NSObject
@property (nonatomic) AudioComponentInstance toneUnit;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) id delegate;
@property (nonatomic) double frequency;
@property (nonatomic) double sampleRate;
@property (nonatomic) double theta;

- (void)play:(float)ms;
- (void)play;
- (void)stop;
- (void)createToneUnit;
@end
