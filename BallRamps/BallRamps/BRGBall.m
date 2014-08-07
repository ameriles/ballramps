//
//  BRGBall.m
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import "BRGBall.h"

static const int kBallSpeed = 320;

@implementation BRGBall

-(BRGBall *)initAt:(CGPoint)position {
    if (self = [super init]) {
        static NSArray *colours;
        if (!colours) {
            colours = @[@"ball", @"ball_blue", @"ball_green"];
        }
        
        int index = arc4random_uniform(3);
        
        SKTextureAtlas *textureAtlas = [[BRGDeviceHelper sharedHelper] textureAtlasNamed:@"sprites"];
        _sprite = [SKSpriteNode spriteNodeWithTexture:[textureAtlas textureNamed:colours[index]]];
        _sprite.zPosition = 1;
        _sprite.position = position;
        _sprite.anchorPoint = CGPointMake(0, 0);
        
        _isFalling = NO;
    }
    
    return self;
}

-(void)updatePosition:(CFTimeInterval)timeSinceLast {
    if (_isFalling) {
        _sprite.position = CGPointMake(_sprite.position.x, _sprite.position.y - kBallSpeed * timeSinceLast);
    }
}

-(void)fall {
    _isFalling = YES;
//    
//    SKAction *easeMoveDown = [SKAction moveToY:0 duration:1.0f];  // por ahora va hacia 0
//    easeMoveDown.timingMode = SKActionTimingEaseInEaseOut;
//    [_sprite runAction:easeMoveDown completion:^{
//        //[self stopFall];
//    }];
}

-(void)stopFall {
    _isFalling = NO;
    //[_sprite removeAllActions];
    _sprite.position = CGPointMake(_sprite.position.x, (((int)_sprite.position.y / kBallSize) + 1) * kBallSize);
}

@end
