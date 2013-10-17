//
//  AppDelegate.m
//  cocoa_drawing_project
//
//  Created by Alberto Morales on 10/17/13.
//  Copyright (c) 2013 Alberto Morales. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawingViewController.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.drawingViewController = [[DrawingViewController alloc] initWithWindow:self.window];

}

@end
