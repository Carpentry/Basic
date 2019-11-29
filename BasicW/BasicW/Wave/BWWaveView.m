//
//  BWWaveView.m
//  BasicW
//
//  Created by 小李 on 2019/11/13.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWWaveView.h"
@interface BWWaveView ()
@property (nonatomic, assign) CGFloat phase;
@property (nonatomic) CGFloat amplitude;
@property (nonatomic) NSMutableArray *waves;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end
@implementation BWWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.waves = [[NSMutableArray alloc] init];
    self.frequency = 1.2f;
    self.amplitude = 1.0f;
    self.idleAmplitude = 0.01f;
    self.numberOfWaves = 5;
    self.phaseShift = -0.25f;
    self.density = 1.f;
    self.waveColor = [UIColor whiteColor];
    self.mainWaveWidth = 2.0f;
    self.decorativeWavesWidth = 1.0f;
    self.waveHeight = CGRectGetHeight(self.bounds);
    self.waveWidth = CGRectGetWidth(self.bounds);
    self.waveMid = self.waveWidth / 2.0f;
    self.maxAmplitude = self.waveHeight - 4.0f;
}


- (void)setWaveLevelCallback:(void (^)(BWWaveView * waver))WaveLevelCallback {
    _WaveLevelCallback = WaveLevelCallback;

    [self.displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    for(int i=0; i < self.numberOfWaves; i++)
    {
        CAShapeLayer *waveline = [CAShapeLayer layer];
        waveline.lineCap       = kCALineCapButt;
        waveline.lineJoin      = kCALineJoinRound;
        waveline.strokeColor   = [[UIColor clearColor] CGColor];
        waveline.fillColor     = [[UIColor clearColor] CGColor];
        [waveline setLineWidth:(i==0 ? self.mainWaveWidth : self.decorativeWavesWidth)];
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
        UIColor *color = [self.waveColor colorWithAlphaComponent:(i == 0 ? 1.0 : 1.0 * multiplier * 0.4)];
        waveline.strokeColor = color.CGColor;
        [self.layer addSublayer:waveline];
        [self.waves addObject:waveline];
    }
    
}

- (void)invokeWaveCallback {
    self.WaveLevelCallback(self);
}

- (void)setLevel:(CGFloat)level {
    _level = level;
    self.phase += self.phaseShift;
    self.amplitude = fmax(level, self.idleAmplitude);
    [self updateMeters];
}

- (void)updateMeters {
    self.waveHeight = CGRectGetHeight(self.bounds);
    self.waveWidth = CGRectGetWidth(self.bounds);
    self.waveMid = self.waveWidth / 2.0f;
    self.maxAmplitude = self.waveHeight - 4.0f;
    UIGraphicsBeginImageContext(self.frame.size);
    for (int i = 0; i < self.numberOfWaves; i++) {
        UIBezierPath *wavelinePath = [UIBezierPath bezierPath];
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        CGFloat normedAmplitude = (1.5f * progress - 0.5f) * self.amplitude;
        for (CGFloat x = 0; x < self.waveWidth + self.density; x += self.density) {
            CGFloat scaling = - pow(x/self.waveMid - 1, 2) + 1;
            CGFloat y = scaling * self.maxAmplitude * normedAmplitude *sinf(2 * M_PI * (x/self.waveWidth) * self.frequency + self.phase) + (self.waveHeight + 0.5);
            if (x == 0) {
                [wavelinePath moveToPoint:CGPointMake(x, y)];
            } else {
                [wavelinePath addLineToPoint:CGPointMake(x, y)];
            }
        }
        CAShapeLayer *waveline = [self.waves objectAtIndex:i];
        waveline.path = [wavelinePath CGPath];
    }
    
    UIGraphicsEndImageContext();
}


- (void)dealloc
{
    [_displayLink invalidate];
}

@end
