//
//  Ball.h
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : NSObject

extern const double DIAMETER_TO_WINDOW_WIDTH_RATIO;

@property CGPoint startPoint;
@property double diameter;
@property NSRect frame;

-(id) initWithInitialLocation:(CGPoint) initialPoint insideOfFrame: (NSRect) initialWindowFrame;

-(void) adjustBallBasedOnWindowFrame: (NSRect) frame;

-(void) draw;

@end
