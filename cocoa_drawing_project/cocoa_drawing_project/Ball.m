//
//  Ball.m
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import "Ball.h"

@implementation Ball


-(id) initWithInitialLocation:(CGPoint)initialPoint insideOfFrame:(NSRect)initialWindowFrame {
    self = [super init];
    self.startPoint = initialPoint;
    self.horizontalMovementDirection = +1.0;
    self.verticalMovementDirection = +1.0;
    [self adjustBallBasedOnWindowFrame:initialWindowFrame];
    return self;
}

-(void) adjustBallBasedOnWindowFrame: (NSRect) windowFrame {
    [self adjustDiameterBasedOnWindowFrame:windowFrame];
    [self adjustStartPointBasedOnWindowFrame:windowFrame];
    self.frame = CGRectMake(self.startPoint.x, self.startPoint.y, self.diameter, self.diameter);
}

const double N_TIMES_SMALLER_THAN_WINDOW_HEIGHT = 20;

-(void) adjustDiameterBasedOnWindowFrame: (NSRect) windowFrame {
    self.diameter = windowFrame.size.height / N_TIMES_SMALLER_THAN_WINDOW_HEIGHT;
}

-(void) adjustStartPointBasedOnWindowFrame: (NSRect) windowFrame {
    if (self.startPoint.x < 0) {
        self.startPoint = CGPointMake(0, self.startPoint.y);
        self.horizontalMovementDirection = +1.0;
    }
    
    if (self.startPoint.y < 0) {
        self.startPoint = CGPointMake(self.startPoint.x, 0);
        self.verticalMovementDirection = +1.0;
    }
    
    double rightEdgeWindow = windowFrame.origin.x+windowFrame.size.width;
    double rightEdgeBall = self.startPoint.x + self.diameter;
    if (rightEdgeBall > rightEdgeWindow) {
        self.startPoint = CGPointMake((rightEdgeWindow-self.diameter), self.startPoint.y);
        self.horizontalMovementDirection = -1.0;
    }
    
    double bottomEdgeWindow = windowFrame.origin.y+windowFrame.size.height;
    double bottomEdgeBall = self.startPoint.y + self.diameter;
    if (bottomEdgeBall > bottomEdgeWindow) {
        self.startPoint = CGPointMake(self.startPoint.x, (bottomEdgeWindow-self.diameter));
        self.verticalMovementDirection = - 1.0;
    }
}

-(void) draw {
    [[NSColor blueColor] set];
    [self drawAndFillCircleInsideofFrame];
}

-(void) drawAndFillCircleInsideofFrame {
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath appendBezierPathWithOvalInRect:self.frame];
    [thePath fill];
}



-(void) move {
    double new_x_position = self.startPoint.x + (self.horizontalMovementDirection * [self movementIncrement]);
    double new_y_position = self.startPoint.y + (self.verticalMovementDirection * [self movementIncrement]);
    self.startPoint = CGPointMake(new_x_position, new_y_position);
}

const double MOVEMENT_INCREMENT = 5.0;

-(double) movementIncrement {
    return self.diameter * MOVEMENT_INCREMENT;
}


@end
