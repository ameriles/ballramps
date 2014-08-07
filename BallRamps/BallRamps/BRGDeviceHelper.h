//
//  BRGDeviceHelper.h
//  BallRamps
//
//  Created by Agustin on 28/06/14.
//  Copyright (c) 2014 Agustin. All rights reserved.
//

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface BRGDeviceHelper : NSObject

+ (BRGDeviceHelper *) sharedHelper;

- (SKTextureAtlas *)textureAtlasNamed:(NSString *)fileName;

@end
