//
//  BRGMyScene.m
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import "BRGMyScene.h"

@implementation BRGMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */

        // Create a level
        self.currentLevel = [[BRGLevel alloc] initInScene:self withNumber:1 andBackgroundNamed:@"city_bg"];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
//    if ([self.currentLevel hasFallingBall]) {
//        return;
//    } else if ([self.currentLevel isBallSetToFall]) {
//        [self.currentLevel shootBall];
//    }
    
    [self.currentLevel prepareAnotherBall];
    
    
    // si el cañon está presto para disparar, es el momento para dibujar las rampas
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInNode:self];
//    NSLog(@"%f %f", point.x, point.y);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    //[self.currentLevel updateBall: currentTime];
}

@end
