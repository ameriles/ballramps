//
//  BRGBall.h
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BRGDeviceHelper.h"

@interface BRGBall : NSObject

@property (strong, nonatomic, readonly) SKSpriteNode *sprite;

-(BRGBall *)initAt:(CGPoint)position;
-(void)fall;
-(BOOL)isResting;

@end
