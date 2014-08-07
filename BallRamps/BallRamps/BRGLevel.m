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
    SKSpriteNode *_bottom;
    CFTimeInterval _lastUpdateTimeInterval;
}

-(BRGLevel *)initInScene: (SKScene *)scene withNumber:(NSInteger)number andBackgroundNamed:(NSString *)bgName {
    if (self = [super init]) {
        _scene = scene;
        _number = number;
        _ballStartY = CGRectGetMaxY(scene.frame);
        
        // TODO optimizar con manager de atlas o backgrounds
        SKTextureAtlas *backgroundAtlas = [[BRGDeviceHelper sharedHelper] textureAtlasNamed:@"backgrounds"];
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[backgroundAtlas textureNamed:@"city_bg"]];
        
        _bottom = [SKSpriteNode spriteNodeWithTexture:[backgroundAtlas textureNamed:@"bottom"]];
        
        _balls = [NSMutableArray array];
        
        // Add to scene
        background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
        background.zPosition = 0;
        
        _bottom.anchorPoint = CGPointMake(.5f, 0);
        _bottom.position = CGPointMake(CGRectGetMidX(scene.frame), 0);
        _bottom.zPosition = 1;
        
        [scene addChild:background];
        [scene addChild:_bottom];
        
        [self prepareAnotherBall];
    }
    
    return self;
}

-(BOOL)hasFallingBall {
    return [_currentBall isFalling];
}

-(void)shootBall {
    [_currentBall fall];
}

-(void)updateBall:(CFTimeInterval)currentTime {
    CFTimeInterval timeSinceLast = currentTime - _lastUpdateTimeInterval;
    _lastUpdateTimeInterval = currentTime;
    
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
    }
    
    // Actualiza la posición del sprite de la bola
    [_currentBall updatePosition: timeSinceLast];
    
    // Verifica si hay interseccion de la bola que cae con las del nivel
    if ([_currentBall.sprite intersectsNode:_bottom]) {
        [self prepareAnotherBall];
        return;
    }
    
    for (BRGBall *ball in self.balls) {
        if ([_currentBall.sprite intersectsNode:ball.sprite]) {
            [self prepareAnotherBall];
            return;
        }
    }
}

-(BOOL)isBallSetToFall {
    return [_currentBall isSetToFall];
}

#pragma mark - Private Methods

-(void)prepareAnotherBall {
    if (_currentBall) {
        [_currentBall stopFall];
        [self.balls addObject:_currentBall];
    }
        
    _currentBall = [[BRGBall alloc] initAt:[self randomStartPoint]];
    _currentBall.isSetToFall = YES;
    
    // Add sprite to scene
    [_scene addChild:_currentBall.sprite];
}

-(CGPoint)randomStartPoint {
    int x = (arc4random_uniform(9) * kBallSize) + kLevelMargin;
    return CGPointMake((float)x, _ballStartY);
}
@end
