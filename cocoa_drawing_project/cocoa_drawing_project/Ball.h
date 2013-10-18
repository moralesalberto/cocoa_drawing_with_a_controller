//
//  Ball.h
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : NSObject

extern const double N_TIMES_SMALLER_THAN_WINDOW_HEIGHT;

@property CGPoint startPoint;
@property double diameter;
@property NSRect frame;

-(id) initWithInitialLocation:(CGPoint) initialPoint insideOfFrame: (NSRect) initialWindowFrame;

-(void) adjustBallBasedOnWindowFrame: (NSRect) frame;

-(void) draw;

@end
