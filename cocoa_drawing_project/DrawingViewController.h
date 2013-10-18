//
//  DrawingViewController.h
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DrawingView.h"
#import <QuartzCore/QuartzCore.h>

@interface DrawingViewController : NSViewController

@property NSWindow *window;

@property DrawingView *drawingView;

@property NSTimer * timer;


-(id) initWithWindow:(NSWindow *) theWindow;

- (void)moveBall:(NSTimer *)timer;

@end
