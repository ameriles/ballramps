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
    
    // Create ramp
    if (![self.currentLevel isSettingRamp]) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInNode: self];
        
        [self.currentLevel setRamp: point];
    }
    
    // Ball
    if ([self.currentLevel isReadyForNewBall]) {
        [self.currentLevel prepareAnotherBall];
        [self.currentLevel shootBall];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.currentLevel isSettingRamp]) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInNode: self];
        [self.currentLevel moveRamp:point];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.currentLevel isSettingRamp]) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInNode: self];
        [self.currentLevel finishRamp:point];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    //[self.currentLevel updateBall: currentTime];
    
    [self.currentLevel checkBall];
}

@end
