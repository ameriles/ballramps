//
//  BRGLevel.m
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import "BRGLevel.h"

static const int kLevelMargin = 52;

@implementation BRGLevel {
    SKScene *_scene;
    float _ballStartY;
    CFTimeInterval _lastUpdateTimeInterval;
    BRGRamp *_ramp;
}

-(BRGLevel *)initInScene: (SKScene *)scene withNumber:(NSInteger)number andBackgroundNamed:(NSString *)bgName {
    if (self = [super init]) {
        _scene = scene;
        _number = number;
        _ballStartY = CGRectGetMaxY(scene.frame);

        SKPhysicsBody *borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:_scene.frame];
        _scene.physicsBody = borderBody;
        //_scene.physicsWorld.gravity = CGVectorMake(0.0f, -2.0f);
        
        // TODO optimizar con manager de atlas o backgrounds
        SKTextureAtlas *backgroundAtlas = [[BRGDeviceHelper sharedHelper] textureAtlasNamed:@"backgrounds"];
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[backgroundAtlas textureNamed:@"city_bg"]];
        
        _balls = [NSMutableArray array];
        
        // Add to scene
        background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
        background.zPosition = 0;
        
        [scene addChild:background];
        
        _isReadyForNewBall = YES;
    }
    
    return self;
}

-(void)shootBall {
    [_currentBall fall];
    _isReadyForNewBall = NO;
}

-(void)checkBall {
    if ([_currentBall isResting]) {
        [_balls addObject:_currentBall];
        _isReadyForNewBall = YES;
        _currentBall = nil;
    }
}

// Añade el ramp
-(void)setRamp:(CGPoint)origin {
    _ramp = [[BRGRamp alloc] initAt:origin];
    [_scene addChild:_ramp.sprite];
    _isSettingRamp = YES;
}

-(void)moveRamp:(CGPoint)destination {
    [_ramp move:destination];
}

-(void)finishRamp:(CGPoint)destination {
    [self moveRamp: destination];
    //_isSettingRamp = NO;
}

-(void)prepareAnotherBall {
    _currentBall = [[BRGBall alloc] initAt:[self randomStartPoint]];
    
    // Add sprite to scene
    [_scene addChild:_currentBall.sprite];
}

// TODO Agregar un event handler para detectar que la bola toco el fondo y está en reposo.
// entonces poner _isReadyForNewBall = YES y agregar a la bola a la coleccion

#pragma mark - Private Methods
-(CGPoint)randomStartPoint {
    int x = (arc4random_uniform(9) * kBallSize) + kLevelMargin;
    return CGPointMake((float)x, _ballStartY);
}
@end
