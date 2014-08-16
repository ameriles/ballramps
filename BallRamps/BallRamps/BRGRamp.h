//
//  BRGRamp.h
//  BallRamps
//
//  Created by Agustin on 16/08/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BRGDeviceHelper.h"

@interface BRGRamp : NSObject

@property (strong, nonatomic, readonly) SKSpriteNode *sprite;

-(BRGRamp *)initAt:(CGPoint)position;

-(void)move:(CGPoint)destination;

@end
