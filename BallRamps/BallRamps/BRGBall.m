//
//  BRGBall.m
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import "BRGBall.h"

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
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_sprite.frame.size.width/2];
        _sprite.physicsBody.restitution = .75f;
        _sprite.physicsBody.mass = .25f;
        //_sprite.physicsBody.friction =
        
        _isFalling = NO;
    }
    
    return self;
}

-(void)fall {
    _isFalling = YES;
    [_sprite.physicsBody applyImpulse:CGVectorMake(0.0f, -1.0f)];
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
    // _sprite.position = CGPointMake(_sprite.position.x, (((int)_sprite.position.y / kBallSize) + 1) * kBallSize);
}

@end
