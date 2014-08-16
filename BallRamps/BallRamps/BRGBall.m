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
        
        int index = arc4random_uniform([colours count]);
        
        SKTextureAtlas *textureAtlas = [[BRGDeviceHelper sharedHelper] textureAtlasNamed:@"sprites"];
        _sprite = [SKSpriteNode spriteNodeWithTexture:[textureAtlas textureNamed:colours[index]]];
        _sprite.zPosition = 1;
        _sprite.position = position;
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_sprite.frame.size.width/2];
        _sprite.physicsBody.restitution = .5f;
        _sprite.physicsBody.mass = .25f;
        //_sprite.physicsBody.friction =
    }
    
    return self;
}

-(void)fall {
    [_sprite.physicsBody applyImpulse:CGVectorMake(0.0f, -.1f)];
}

-(BOOL)isResting {
    return fabsf(_sprite.physicsBody.velocity.dx) <= 0.1f && fabsf(_sprite.physicsBody.velocity.dy) <= 0.1f;
}

@end
