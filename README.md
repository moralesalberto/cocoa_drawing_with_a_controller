Cocoa Drawing With A Controller
===============================

This is a more involved cocoa drawing example. We need a controller class to control what gets drawn in the view.

In this example we will draw a bouncing ball around the cocoa app default window.

We start with a template cocoa app from XCode. Then we create a NSViewController class with New File -> Objective C class and inherit from NSViewController. Let's call the class DrawingViewController. We also will need an NSView custom class. So New File -> Objective C class -> inherit from NSView and call it DrawingView.

I am not sure how to get a handle to the window from the controller, so I will create an NSWindow property on my controller and will have a custom init method that will get the window from the AppDelegate.m file.

In the AppDelegate.h file I add the window property:
``` objective-c
#import <Cocoa/Cocoa.h>

#import "DrawingViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property DrawingViewController *drawingWindowController;


@end
```

And in the AppDelegate.m file I instantiate the controller and pass a reference to the application default window.

``` objective-c
#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.drawingWindowController = [[DrawingViewController alloc] initWithWindow:self.window];
}

@end
```

In the DrawingWindowController class, I create a custom constructor method called initWithWindow: like this. Do not forget to add the interface of this method in the DrawingViewController.h file. Notice that as I am instantiating the controller, I go ahead and instantiate the view and set the controller view to the custom DrawingView just instantiated. Also, since we have a reference to the App default window, we set the ContentView: of that window to be our view.


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

So now we have the wiring set between the app delegate and our view and in between, we have our controller object that will orchestrate what to draw in the view.

For this example, we will have a bouncing ball, bouncing around the window because when the ball hits one of the bounds of the window, the ball with reverse direction.
