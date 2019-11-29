//
//  BWWaveViewController.m
//  BasicW
//
//  Created by 小李 on 2019/11/13.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWWaveViewController.h"
#import "BWWaveView.h"
#import <AVFoundation/AVFoundation.h>

@interface BWWaveViewController ()
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation BWWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRecorder];
    BWWaveView *wv = [[BWWaveView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)/2.0 - 50, CGRectGetWidth(self.view.bounds), 100)];
    __block AVAudioRecorder *weakRecoder = self.recorder;
    wv.WaveLevelCallback = ^(BWWaveView * _Nonnull wv) {
        [weakRecoder updateMeters];
        CGFloat normalizedValue = pow(10, [weakRecoder averagePowerForChannel:0]/40);
        wv.level = normalizedValue;
    };
    [self.view addSubview:wv];
}

- (void)setupRecorder {
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *setting = @{AVSampleRateKey:          [NSNumber numberWithFloat:44100.0],
                              AVFormatIDKey:            [NSNumber numberWithInt:kAudioFormatAppleLossless],
                              AVNumberOfChannelsKey:    [NSNumber numberWithInt:2],
                              AVEncoderAudioQualityKey: [NSNumber numberWithInt:AVAudioQualityMin]
    };
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
    if (error) {
        NSLog(@"ups, could not create recorder %@",error);
        return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"Error setting category:%@",[error description]);
    }
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder record];
}



@end
