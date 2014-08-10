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

@interface BRGLevel : NSObject

@property (nonatomic, readonly) NSInteger number;
@property (strong, nonatomic, readonly) NSMutableArray *balls;
@property (strong, nonatomic) BRGBall *currentBall;

-(BRGLevel *)initInScene:(SKScene *)scene withNumber:(NSInteger)number andBackgroundNamed:(NSString *)bgName;

-(BOOL)hasFallingBall;

-(void)shootBall;

-(void)updateBall:(CFTimeInterval)currentTime;

-(BOOL)isBallSetToFall;

-(void)prepareAnotherBall;

@end
