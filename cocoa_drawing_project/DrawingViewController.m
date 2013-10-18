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
    [self setView:[[DrawingView alloc] initWithFrame:self.window.frame]];
    [self.window setContentView:self.view];
    [self animateBall];
    return self;
}

-(void) animateBall {
    //start a timer
    //timer will call a method called [ball move]
}

@end
