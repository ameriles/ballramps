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
        SKSpriteNode *tubes = [SKSpriteNode spriteNodeWithTexture:[backgroundAtlas textureNamed:@"tubes"]];
        
        _balls = [NSMutableArray array];
        
        // Add to scene
        background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
        background.zPosition = 0;
        
        tubes.position = CGPointMake(kLevelMargin + (tubes.frame.size.width / 2) - (kBallSize / 2), tubes.frame.size.height/2);
        tubes.zPosition = 2;
        
        float baseX = kLevelMargin - (kBallSize / 2);
        for (int i = 1; i <= 10; i++) {
            SKNode *node = [[SKNode alloc] init];
            node.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(baseX, 0) toPoint:CGPointMake(baseX, tubes.frame.size.height)];
            node.physicsBody.affectedByGravity = NO;
            node.physicsBody.mass = 1000000.0f;
            [scene addChild:node];
            
            baseX += (kBallSize + 3); // TODO MAGIC NUMBER 3. SEPARATION OF TUBES
        }
        
        
        [scene addChild:background];
        [scene addChild:tubes];
        
        
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
-(void)setRamp:(CGPoint)position {
    if (!_ramp) {
        _ramp = [[BRGRamp alloc] initAt:position];
       [_scene addChild:_ramp.sprite];
    } else {
        [_ramp setAt: position];
    }

    _isSettingRamp = YES;
}

-(void)rotateRamp:(CGPoint)position {
    [_ramp rotate:position];
}

-(void)finishRamp:(CGPoint)position {
    [self rotateRamp: position];
    _isSettingRamp = NO;
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
    int x = (arc4random_uniform(9) * (kBallSize + 3)) + kLevelMargin;
    NSLog(@"ball shot at x: %d", x);
    return CGPointMake((float)x, _ballStartY);
}
@end
