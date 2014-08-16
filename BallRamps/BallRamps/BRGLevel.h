//
//  BRGLevel.h
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BRGDeviceHelper.h"
#import "BRGBall.h"
#import "BRGRamp.h"

@interface BRGLevel : NSObject

@property (nonatomic, readonly) NSInteger number;
@property (strong, nonatomic, readonly) NSMutableArray *balls;
@property (strong, nonatomic) BRGBall *currentBall;
@property (nonatomic, readonly) BOOL isReadyForNewBall;
@property (nonatomic, readonly) BOOL isSettingRamp;

-(BRGLevel *)initInScene:(SKScene *)scene withNumber:(NSInteger)number andBackgroundNamed:(NSString *)bgName;

-(void)shootBall;

-(void)checkBall;

-(void)prepareAnotherBall;

-(void)setRamp:(CGPoint)origin;

-(void)moveRamp:(CGPoint)destination;

-(void)finishRamp:(CGPoint)destination;

@end
