Cocoa Drawing With A Controller
===============================

This is a more involved cocoa drawing example.  In this example we will draw a bouncing ball around the cocoa app default 
window. We need a controller class to control the movements of the ball drawn in the view.

We start with a template cocoa app from XCode. Then we create a NSViewController class with New File -> Objective C class 
and inherit from NSViewController. Let's call the class DrawingViewController. We also will need an NSView custom class.
So New File -> Objective C class -> inherit from NSView and call it DrawingView.  I am not sure how to get a handle to the
window from the controller, so I will create an NSWindow property on my controller and will have a custom init method that
will get the window from the AppDelegate.m file.

In the AppDelegate.h file I add the custom DrawingViewController property:

``` objective-c
#import <Cocoa/Cocoa.h>

#import "DrawingViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property DrawingViewController *drawingWindowController;

@end
```

And in the AppDelegate.m file I instantiate the controller and when I instantiate the controller, I pass a reference to the application default window.

``` objective-c
#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.drawingWindowController = [[DrawingViewController alloc] initWithWindow:self.window];
}

@end
```

In the DrawingWindowController class, I create a custom constructor method called initWithWindow: and add a property to hold a reference to the app delegate default
window.


``` objective-c
#import <Cocoa/Cocoa.h>
#import "DrawingView.h"

@interface DrawingViewController : NSViewController

@property NSWindow *window;

-(id) initWithWindow:(NSWindow *) theWindow;

@end
```

In the implementation file, notice that as I am instantiating the controller, I go ahead and instantiate the view as well and 
set the controller view to the custom DrawingView just instantiated. Also, since we have a reference to the App default window, 
we set the ContentView: of that window to be our view.

``` objective-c
#import "DrawingViewController.h"

@implementation DrawingViewController

-(id) initWithWindow:(NSWindow *) theWindow {
    self = [super init];
    self.window = theWindow;
    [self setView:[[DrawingView alloc] initWithFrame:self.window.frame]];
    [self.window setContentView:self.view];
    return self;
}

@end
```

So now we have the wiring set between the app delegate and our view and in between, we have our controller object that will
orchestrate what to draw in the view. For this example, we will have a bouncing ball, bouncing around the window so that
when the ball hits one of the bounds of the window, the ball with reverse direction and maybe change color; let's see how
make it fun. Also, to allow for resizing, the diameter of the ball should be proportional to the size of the window.


### Drawing the Ball

The ball will be proportional to the window height. So when the window is resized, the ball will adjust in size. So when
the ball is initialized, the size of the ball has to be adjusted. The init method looks like this:

``` objectic-c
-(id) initWithInitialLocation:(CGPoint)initialPoint insideOfFrame:(NSRect)initialWindowFrame {
    self = [super init];
    self.startPoint = initialPoint;
    [self adjustBallBasedOnWindowFrame:initialWindowFrame];
    return self;
```

The adjust method and its helper methods looks like this:

``` objective-c

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
    }
    
    if (self.startPoint.y < 0) {
        self.startPoint = CGPointMake(self.startPoint.x, 0);
    }
    
    double rightEdgeWindow = windowFrame.origin.x+windowFrame.size.width;
    double rightEdgeBall = self.startPoint.x + self.diameter;
    if (rightEdgeBall > rightEdgeWindow) {
        self.startPoint = CGPointMake((rightEdgeWindow-self.diameter), self.startPoint.y);
    }
    
    double bottomEdgeWindow = windowFrame.origin.y+windowFrame.size.height;
    double bottomEdgeBall = self.startPoint.y + self.diameter;
    if (bottomEdgeBall > bottomEdgeWindow) {
        self.startPoint = CGPointMake(self.startPoint.x, (bottomEdgeWindow-self.diameter));
    }
}
```

Finally, to draw the actual ball, we have a draw method that can be called from the view. The method looks like this:

``` objective-c
-(void) draw {
    [[NSColor blueColor] set];
    [self drawAndFillCircleInsideofFrame];
}

-(void) drawAndFillCircleInsideofFrame {
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath appendBezierPathWithOvalInRect:self.frame];
    [thePath fill];
}
```

The interface for the ball class looks like this:

``` objective-c
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
```

Finally in the drawing view, the implementation file looks like this. We implement the drawRect method that will in turn
call the draw method from the ball object.

``` objective-c
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
```

Now if everything is working for you, you should have a blue filled ball inside of your window. Next step will
be to make the ball bounce around the window.

