//
//  BRGDeviceHelper.m
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#import "BRGDeviceHelper.h"

@implementation BRGDeviceHelper

+ (BRGDeviceHelper *)sharedHelper {
    static BRGDeviceHelper *sharedHelper;
    
    @synchronized(self)
    {
        if (!sharedHelper)
            sharedHelper = [[BRGDeviceHelper alloc] init];
        
        return sharedHelper;
    }
}

- (SKTextureAtlas *)textureAtlasNamed:(NSString *)fileName {
    if (IS_WIDESCREEN) {
        // iPhone Retina 4-inch
        fileName = [NSString stringWithFormat:@"%@-568", fileName];
    } else {
        // iPhone Retina 3.5-inch
        fileName = fileName;
    }
    
    SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:fileName];
    return textureAtlas;
}

@end
