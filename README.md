Another shameless copy of an Xcode 4 component. A `NSView` subclass that displays a custom message inside a bubble whenever the view becomes empty (that is, it doesn't have any subviews). When a view is added, the message disappears automatically, similar to the behvaior of Xcode 4's Inspector View when empty.

### Usage
Just make any view an instance of `JUEmptyView` and you are done. The rest is managed automagically for you, however, if you want you can customize the font, text color and background color (the default values copy the Xcode 4 colors), as well as the displayed text.

### Screenshot
![image](http://widerwille.com/stuff/emptyview.png)