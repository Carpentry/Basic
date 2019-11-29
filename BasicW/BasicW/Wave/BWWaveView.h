//
//  BWWaveView.h
//  BasicW
//
//  Created by 小李 on 2019/11/13.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWWaveView : UIView
@property (nonatomic, copy) void (^WaveLevelCallback)(BWWaveView *wv);
@property (nonatomic, assign) NSUInteger numberOfWaves;
@property (nonatomic, strong) UIColor *waveColor;
@property (nonatomic, assign) CGFloat level;
@property (nonatomic, assign) CGFloat mainWaveWidth;
@property (nonatomic, assign) CGFloat decorativeWavesWidth;
@property (nonatomic, assign) CGFloat idleAmplitude;
@property (nonatomic, assign) CGFloat frequency;
@property (nonatomic, assign, readonly) CGFloat amplitude;
@property (nonatomic, assign) CGFloat density;
@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign, readonly) NSMutableArray *waves;
@end

NS_ASSUME_NONNULL_END
