//
//  BRGRamp.m
//  BallRamps
//
//  Created by Agustin on 16/08/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import "BRGRamp.h"

@implementation BRGRamp

-(BRGRamp *)initAt:(CGPoint)position {
    if (self = [super init]) {
        
        SKTextureAtlas *textureAtlas = [[BRGDeviceHelper sharedHelper] textureAtlasNamed:@"sprites"];
        _sprite = [SKSpriteNode spriteNodeWithTexture:[textureAtlas textureNamed:@"table"]];
        _sprite.zPosition = 1;
        _sprite.position = position;
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.frame.size];
        _sprite.physicsBody.restitution = 0.0f;
        _sprite.physicsBody.mass = 1000.0f;
        _sprite.physicsBody.affectedByGravity = NO;
        
        NSLog(@"start %f, %f", _sprite.position.x, _sprite.position.y);
    }
    
    return self;
}

-(void)rotate:(CGPoint)position {
    float catOp = position.y - _sprite.position.y;
    float catAdy = position.x - _sprite.position.x;
    if (catAdy == 0)
        return;
    
    float tan = catOp / catAdy;
    float angle = atanf(tan);
    
    _sprite.zRotation = angle;
    
    NSLog(@"moving %f, %f : %f", position.x, position.y, angle);
}

-(void)setAt:(CGPoint)position {
    _sprite.position = position;
}

@end
