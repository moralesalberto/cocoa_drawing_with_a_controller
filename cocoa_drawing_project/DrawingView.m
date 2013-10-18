//
//  DrawingView.m
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView



-(id) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    self.ball = [[Ball alloc] initWithInitialLocation:frameRect.origin insideOfFrame:frameRect];
    return self;
}


-(void) drawRect:(NSRect)dirtyRect {
    [self.ball adjustBallBasedOnWindowFrame:dirtyRect];
    [self.ball draw];
}


@end
