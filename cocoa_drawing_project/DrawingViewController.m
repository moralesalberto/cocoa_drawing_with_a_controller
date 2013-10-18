//
//  DrawingViewController.m
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import "DrawingViewController.h"

@implementation DrawingViewController

-(id) initWithWindow:(NSWindow *) theWindow {
    self = [super init];
    self.window = theWindow;
    self.drawingView = [[DrawingView alloc] initWithFrame:self.window.frame];
    [self setView:self.drawingView];
    [self.window setContentView:self.view];
    [self animateBall];
    return self;
}

-(void) animateBall {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.20 target:self selector:@selector(moveBall:) userInfo:nil repeats:YES];
}


- (void)moveBall:(NSTimer *)timer {
    [self.drawingView.ball move];
    [self.drawingView setNeedsDisplay:YES];
}

@end
