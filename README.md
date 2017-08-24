*A note: All of the concepts in this post are about creating views programmatically. I do not use Storyboards at all in my projects and therefore do not create views or layout constraints from the interface builder.*

Table of Contents:
- [Intro](#intro)
- [Issues with AutoLayout](#issues-with-autolayout)
- [The make up of a view frame](#the-make-up-of-a-view-frame)
- [Extensions, Math, and Custom Classes](#extensions-math-and-custom-classes)
    - [Extensions/Math](#extensionsmath)
    - [UIView Extensions](#uiview-extensions)
    - [Custom Classes](#custom-classes)
- [Sketch design](#sketch-design)
- [Coding the views](#coding-the-views)
    - [Coding the Top Bar](#coding-the-top-bar)
    - [Coding the Button View](#coding-the-button-view)
    - [Coding the Comments View](#coding-the-comments-view)
    - [Putting it all together](#putting-it-all-together)
- [Drawbacks](#drawbacks)
- [Conclusion](#conclusion)

# Intro

Hello, dear reader!

The other day as I was perusing reddit, I came across a post called something along the lines of "The case against AutoLayout". The post linked to an issue on the [IGList Github repo](https://github.com/Instagram/IGListKit), where Ryan Nystrom, a developer for Instagram, said ["Instagram doesn't use self-sizing-cells or auto layout at all"](https://github.com/Instagram/IGListKit/issues/508). This made me start thinking. I neither love nor hate AutoLayout but I've also never believed there was a different way to create views, and I certainly didn't think that a company as big as Instagram would shy away from the industry standard that is AutoLayout. 

After researching and testing a few ways to create UI without AutoLayout, I believe I have found at least a solid starting point. Today we'll go over the basics and I'll show you how I got from a design in Sketch straight to Xcode using math and not a single AutoLayout constraint.

I will go over some of my issues with AutoLayout, explain some of the math and custom view classes we'll be using, go over our Sketch design, and finally start writing the code in our project. If you'd like to skip to a specific section, please see the table of contents above. Also you can just go straight to the [Github repo](https://github.com/KoalaTeaCode/KTInstagramUIExampleProject) for the full project.

# Issues with AutoLayout

I only have 2 real issues with AutoLayout. They aren't big and I understand there are workarounds or better ways to use AutoLayout to fix them.

1. The original AutoLayout API syntax isn't very understandable and for me, takes too long to write.

	```swift
	let margins = view.layoutMarginsGuide
	myView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
	myView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
	```
	When you have quite a few views, this syntax just becomes unreadable.
	
	I use Snapkit in most of my projects which fixes a lot of my issues with the AutoLayout syntax.
	
	```swift
	myView.snp.makeConstraints { (make) -> Void in
	    make.left.equalToSuperview()
	    make.right.equalToSuperview()
	}
	```
	But the code isn't perfect and it leads me to my second issues:

2. Insets/Constants are not scaled for each screen size. So going from a design on an iPhone to an iPad can be a mess.

	All of my apps are for iPhone and iPad because why not? None of my apps are made just for one screen size or use anything specific to just an iPhone so the only barrier is my UI. AutoLayout is supposed to bridge this gap, but say if when setting up my layout I set an inset of 10 points for the left side of my view:
	
	```swift
	myView.snp.makeConstraints { (make) -> Void in
	    make.left.equalToSuperview().inset(10)
	    make.right.equalToSuperview()
	}
	```
	Well when I launch my app on the iPad simulator, the inset will still be 10 points but the iPad has a much larger screen size. This leads to odd looking views that have been stretched instead of scaled proportionally. 
	
	These issues can seem small but they start to snowball when you're working on a project for a long time, working on multiple projects, or trying to get a UI design from Sketch exactly right to balance your designer's temperament.
	
	If you have no issue with AutoLayout, feel free to read this simply as a discussion about a different way to create UI and not a statement about the right or wrong way to create UI, because there is none.

# The make up of a view frame

Let's quickly talk about view frames. We create views like this:

```swift
UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)
```
Width and height are self explanatory. "x:" is where the origin point(Top left by default) of our view starts on the X Axis(Horizontal). "y:" is where the origin point(Top left by default) of our view starts on the Y Axis(Vertical). (See the diagram below)

![Diagram](http://i.imgur.com/oRrUS6q.png)

Frames also have a min, mid, and max property for the x and y values.

```swift
let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
view.frame.minX
view.frame.midX
view.frame.maxX
```

We can use these properties to get the top left point, top middle point, and top right point of any view. The same goes for the y axis. Using these properties in conjunction we can easily snap views to each other.

# Extensions, Math, and Custom Classes
## Extensions/Math
Before we start creating views, we need two custom extension to help calculate the height, width, and position for our views when they are being scaled for different devices. These two extensions:

```swift
let iphone7Height: CGFloat = 667.0
let iphone7Width: CGFloat = 375.0

extension Int {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

// Extensions in use
let calculatedHeight = 50.scaleForScreenHeight()
let calculatedWidth = 50.scaleForScreenWidth()
```

These extensions follow a simple formula. 

    CurrentScreenHeight / (iPhone7ScreenHeight / NumberToCalculate) = CalculatedHeight

So for a view with a height of 50 on an iPhone 7 the calculations would be so:

    iPhone 7: 50
    iPhone 7+: 55.1724137931035
    iPad Pro(9.7 Inch): 76.7616191904048
    iPad Pro(12.9 Inch): 102.3988005997

Now our view height stays proportional to the screen height with a simple extension.

These extensions are built on top of calculating height and width in relation to an iPhone 7 screen simply because that is where my designs usually start from. You can obviously tweak these to your needs. Also in our project I have these same two extensions created for Double, Float, and CGFloat for simplicities sake.

I'll also probably move away from extensions in the future but for now this works for our general use.

## UIView Extensions
I also made up some UIView extensions to quickly get the points for the frame of a specific view. This will just clean up and shorten a lot of our code. Think of these just like "UIView.frame.center".

```swift
extension UIView {
    func topRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.minY)
    }
    
    func topMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.minY)
    }
    
    func topLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    func bottomRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.maxY)
    }
    
    func bottomMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.maxY)
    }
    
    func bottomLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.maxY)
    }
    
    func leftMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.midY)
    }
    
    func rightMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.midY)
    }
}
```

Here's the full extensions file:

```swift
import UIKit

let iphone7Height: CGFloat = 667.0
let iphone7Width: CGFloat = 375.0

extension Int {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Double {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension CGFloat {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / self
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / self
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Float {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension UIView {
    func topRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.minY)
    }
    
    func topMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.minY)
    }
    
    func topLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    func bottomRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.maxY)
    }
    
    func bottomMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.maxY)
    }
    
    func bottomLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.maxY)
    }
    
    func leftMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.midY)
    }
    
    func rightMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.midY)
    }
}
```

## Custom Classes
For usability we are going to abstract using these extensions to a few custom classes that will inherit from the vanilla UIView, UIButton, UILabel, and UIImageView.

Here are the classes (You can put this all in one file for now):

```swift
import UIKit

// Protocol to make sure we have common function to use to layout subviews
// This is easier than overriding init() in every class
protocol PerformLayoutProtocol {
    func performLayout()
}

// The main responsive view. Our bread and butter going forward
class KTResponsiveView: UIView, PerformLayoutProtocol {
    // Custom width and height variables to quickly return the frame's width and height instead of typing .frame.width every time
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    // We also have custom width/height variables so we can set intrinsice content size
    // This only helps when using StackViews (We'll cover that later)
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    // Our custom init
    //  - Parameters:
    //      - origin: Point of origin (default is (0,0) like a grid)
    //      - topInset: points from the top of immediate superview or origin when set (default is 0)
    //      - leftInset: points from the left of immediate superview or origin when set (default is 0)
    //      - width: width of view. Will be calculated using .scaleForScreenWidth Extension
    //      - height: height of view. Will be calculated using .scaleForScreenHeight Extension
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is where we perform all our layout
    func performLayout() {}
}

class KTButton: UIButton, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is where we perform all our layout
    func performLayout() {}
}

class KTLabel: UILabel, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is where we perform all our layout
    func performLayout() {}
}

class KTImageView: UIImageView, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    init(origin: CGPoint = CGPoint(x: 0, y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat,
         height: CGFloat) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        let newFrame = CGRect(x: cx, y: cy, width: width.scaleForScreenWidth(), height: height.scaleForScreenHeight())
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is where we perform all our layout
    func performLayout() {}
}

// TBH, This is kind of hacked together
class KTEqualImageView: UIImageView, PerformLayoutProtocol {
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    // Our custom init
    //  - Parameters:
    //      - origin: Point of origin (default is (0,0) like a grid)
    //      - topInset: points from the top of immediate superview or origin when set (default is 0)
    //      - leftInset: points from the left of immediate superview or origin when set (default is 0)
    //      - width: width of view. Will be calculated using .scaleForScreenWidth Extension (default is 0)
    //      - height: height of view. Will be calculated using .scaleForScreenHeight Extension (default is 0)
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat = 0,
         height: CGFloat = 0) {
        // Calculate position of new frame
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        // Create new frame
        var cWidth = width.scaleForScreenWidth()
        var cHeight = height.scaleForScreenHeight()
        
        // Here we check if either width or height is 0 which we are assuming means that the variable that isn't 0 should be equal to the variable that has been set
        if width == 0 {
            cWidth = cHeight
        }
        if height == 0 {
            cHeight = cWidth
        }
        let newFrame = CGRect(x: cx, y: cy, width: cWidth, height: cHeight)
        
        super.init(frame: newFrame)
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is where we perform all our layout
    func performLayout() {}
}
```

I know, bit of a code dump but the short version is this:

We have a class for each type of view we will be using that inherits from said type. Each class has relatively the same init method with parameters we use to calculate a new frame for the view. I've also put some notes in the above code to better illustrate this.

# Sketch design
For the actual view we will recreate in Xcode, I have chosen the Post view from Instagram. This is a post I made of my puppy Bandit growing up way too fast. The design is simple and with this we can see how Instagram would not use AutoLayout at all in their app.

I won't go too in-depth into Sketch or our design. You can examine the image below and see that I have used a plugin called [SketchMeasure](http://utom.design/measure/) to measure the height, width, and distance between views for every part of our design. You will be able to see pretty easily how knowing all these measurements will help us in coding the views.

![Full Design](http://i.imgur.com/N8Erfbp.png)
# Coding the views
Finally! Let's stop talking about concepts and get down to the code. 

## Coding the Top Bar
![Top Bar View](http://i.imgur.com/nCo0VGf.png)

Create a new Swift file or create a UIView and call it "TopBarView". Make sure this view inherits from "KTResponsiveView". The let's create variables for all of our views.

```swift
import UIKit

class TopBarView: KTResponsiveView {
    var userImageView: KTEqualImageView!
    var userLabel: KTLabel!
    var ellipsesImageView: KTImageView!
}
```
And instead of overriding the KTResponsive View's init methods, we will override the "performLayout" method.

```swift
override func performLayout() {
}
```
The "performLayout" method works like an init method because we call "performLayout" during the KTResponsiveView's init method. So inside the performLayout method we'll start with the userImageView which contains our user's image(go figure). We will go ahead and initialize a new KTEqualImageView. We'll also make the view circular and add an image.

```swift
userImageView = KTEqualImageView(topInset: 10, leftInset: 10, height: 32)
userImageView.layer.cornerRadius = userImageView.frame.height / 2
userImageView.clipsToBounds = true
userImageView.image = #imageLiteral(resourceName: "userImage")

self.addSubview(userImageView)
```
The origin of the userImageView is by default is the origin of it's superview, TopBarView. So our userImageView will be 10 points from the top of the top TopBarView and 10 points from the left of the left of TopBarView. We set just the height to 32 and since we're using a KTEqualImageView the width will equal the height at all times (If you set just the width for a KTEqualImageView, the height will always equal the width). 

We use a KTEqualImageview here because the height and width for every other view is scaled by different formulas. If we didn't use a KTEqualImageView, when we scale a circular view the view will become more of an oval.

Then we set our corner radius to be the height of the userImageView divided by 2. That will round the view.

We have to set .clipsToBounds to true so that when we add an image it will be masked out and not extend beyond our circular view.

Then we add our image. I'm using an "Image Literal" because I have the asset inside of my project and you can just call the asset by name inside your project.

Finally we have to add our completed view as a subview to our TopBarView class.

Moving on to the userLabel which will contain the username of our user. Here's the code:
 
```swift
...
userLabel = KTLabel(topInset: 10, leftInset: 52, width: 284, height: 32)
userLabel.text = "themisterholliday"
        
userLabel.font = UIFont.systemFont(ofSize: 15.scaleForScreenWidth())
self.addSubview(userLabel)
```

We create a new KTLabel with the same topInset as our userImageView and with a leftInset of 52 so our userLabel origin will start at (10,52) inside our superview which is TopBarView. We also set our font with a size of 15 and use the .scaleForScreenWidth to get an approximate scale for the font to screen size. This isn't a perfect way to scale font right now but I'm working on a better solution.

Then of course we add the userLabel as a subview to TopBarView.

*Side note: We could easily calculate the inset from the right side of the userImageView like so:*
```swift
userLabel = KTLabel(origin: userImageView.topRightPoint(), leftInset: 10, width: 284, height: 32)
```
The inset is 10 from the right side of the userImageView which we can find using userImageView.topRightPoint().

And we're finished with the TopBarView.

## Coding the Button View
![Button View](http://i.imgur.com/Hcf6MSf.png)

* For the Button View we don't do anything too crazy, so I'm just going to throw the code for the class up here.
```swift
import UIKit

class ButtonView: KTResponsiveView {
    var heartButton: KTButton!
    var commentButton: KTButton!
    var shareButton: KTButton!
    var bookmarkButton: KTButton!
    
    override func performLayout() {
        // Heart Button
        heartButton = KTButton(topInset: 13, leftInset: 14, width: 24, height: 22)
        heartButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
        heartButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(heartButton)
        
        // Comment Button
        commentButton = KTButton(topInset: 13, leftInset: 55, width: 24, height: 22)
        commentButton.setImage(#imageLiteral(resourceName: "Comment"), for: .normal)
        commentButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(commentButton)
        
        // Share Button
        shareButton = KTButton(topInset: 13, leftInset: 94, width: 24, height: 22)
        shareButton.setImage(#imageLiteral(resourceName: "Message"), for: .normal)
        shareButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(shareButton)
        
        // Bookmark Button
        bookmarkButton = KTButton(topInset: 13, leftInset: 343, width: 24, height: 22)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark"), for: .normal)
        bookmarkButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(bookmarkButton)
    }
}
```
## Coding the Comments View
![Comments View](http://i.imgur.com/g5TdKV1.png)

The comments view isn't super complicated but we do a few new concepts that I'll cover. But of course every view starts the same.
```swift
import UIKit

class CommentsView: KTResponsiveView {
    var likeLabel: KTLabel!
    var descriptionLabel: KTLabel!
    var moreLabel: KTLabel!
    var viewAllCommentsLabel: KTLabel!
    var timeLabel: KTLabel!
}
```

We use the performLayout method again
```swift
override func performLayout() {
}
```

In our performLayout method we will start with our first label:
```swift
let labelsWidth: CGFloat = 375 - (16 * 2)
        
likeLabel = KTLabel(leftInset: 16, width: labelsWidth, height: 18)
let likesCount = 287
let likesString = "likes"
        
likeLabel.font = UIFont.boldSystemFont(ofSize: 15.scaleForScreenWidth())
likeLabel.text = String(likesCount) + " " + likesString
self.addSubview(likeLabel)
```

We create a variable called "labelsWidth" because all our labels will have the same width. If you look at the Sketch design you can see that there is a 16 point inset on both sides of each label so we just multiply 16 with a calculated width by 2 and subtract the total frame width by the outcome. We're using 375 because that is the width of an iPhone 7 screen.

Next we create our description label:
```swift
descriptionLabel = KTLabel(origin: likeLabel.bottomLeftPoint(), width: labelsWidth, height: 42)
let username = "themisterholliday"
let description = "Hey this is an awesome description"

descriptionLabel.numberOfLines = 0

let fullMutableString = NSMutableAttributedString()
let usernameMutableString = NSMutableAttributedString(
    string: username,
    attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15.scaleForScreenWidth())])
let spaceString = NSMutableAttributedString(string: " ")
let descMutableString = NSMutableAttributedString(
    string: description,
    attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.scaleForScreenWidth())])
fullMutableString.append(usernameMutableString)
fullMutableString.append(spaceString)
fullMutableString.append(descMutableString)

descriptionLabel.attributedText = fullMutableString
self.addSubview(descriptionLabel)
```

We snap the description labels origin point to the bottom left of the likeLabel by using "likeLabel.bottomLeftPoint()", use the same width, and a height of 42. We also want the username to be bold for this label so we do a bit of fiddling around with attributed strings. There are much better ways to work with attributed strings here but I just threw this together and it works for our use here.

Our second to last label is the viewAllCommentsLabel. In the actual Instagram app, you can see the last comment that was made on that specific post but we're going to avoid that for now since we'd need to use a stackView and hide/show labels when there are a certain number of comments. That's a bit much for this tutorial but i'll fit that into it's own smaller tutorial. 

Here is the viewAllCommentsLabel code:
```swift
viewAllCommentsLabel = KTLabel(origin: descriptionLabel.bottomLeftPoint(), width: labelsWidth, height: 20)
viewAllCommentsLabel.text = "View all 5 comments"
viewAllCommentsLabel.font = UIFont.systemFont(ofSize: 14.scaleForScreenWidth())
self.addSubview(viewAllCommentsLabel)
```

Our last label is the timeLabel. Nothing complicated here:
```swift
timeLabel = KTLabel(origin: viewAllCommentsLabel.bottomLeftPoint(), width: labelsWidth, height: 24)
timeLabel.text = "3 HOURS AGO"
timeLabel.font = UIFont.systemFont(ofSize: 11.scaleForScreenWidth())
self.addSubview(timeLabel)
```

Lastly for this view, I'm going to show you a way for a view like this to calculate it's own height depending on the sum of it's subviews. We can quickly accomplish this like so:
```swift
var height: CGFloat = 0
for view in subviews {
    height += view.frame.height
}
self.frame.size.height = height
```
I'm adding this because not only will we want to add another label or two but labels can have multiple lines and descriptions can get very long in Instagram. There are a few tricks we'll need to use to correctly calculate the height for each label and at the end this snippet will calculate the sum of every subviews height.

And that is it for the comments view.

## Putting it all together
Now that we have all of our individual views, let's put all of them together in another view that would be our view to use in a collectionViewCell with some setup functions, but we created some default data for every view so we won't do any of that today. We're just going to call this new view in a view controller.

Start out like we do with our other views:
```swift
import UIKit

class PostView: KTResponsiveView {
    var topBarView: TopBarView!
    var postImageView: KTEqualImageView!
    var buttonView: ButtonView!
    var commentsView: CommentsView!
    
    override func performLayout() {
    }
}
```

You see that we skipped over the postImageView and that's only because it is simply an image and doesn't need to be a separate view.

Let's initialize all our views in the performLayout method:
```swift
topBarView = TopBarView(width: 375, height: 54)
self.addSubview(topBarView)

postImageView = KTEqualImageView(origin: topBarView.bottomLeftPoint(), width: 375)
postImageView.image = #imageLiteral(resourceName: "postImage")
self.addSubview(postImageView)

buttonView = ButtonView(origin: postImageView.bottomLeftPoint(), width: 375, height: 48)
self.addSubview(buttonView)

commentsView = CommentsView(origin: buttonView.bottomLeftPoint(), width: 375, height: 0)
self.addSubview(commentsView)
```

Hopefully by now you can tell what we're doing here by snapping every view to the bottom of the view above it.

And if we'd like to use this PostView in a view controller all we have to do is use it like this:

```swift
class ViewController: UIViewController {

    var postView: PostView!

    override func viewDidLoad() {
        super.viewDidLoad()
        postView = PostView(width: 375, height: 960)
        self.view.addSubview(postView)
    }
}
```

Also I hope you caught that I am not adding the subviews height's together and setting the PostView's height based on that. That is something that I'll leave for another post to cover all together or for you to figure out on the side.

After we create the PostView and initialize it in a view controller. We should see the full view in our project like this:

On iPhone 7:

[iPhone 7 Screenshot](http://i.imgur.com/vON8lKN.png)

On iPhone 7 Plus:

[iPhone 7 Plus Screenshot](http://i.imgur.com/ceRdaCh.png)

On iPad Pro (12.9 inch):

[iPad Pro (12.9 inch) Screenshot](http://i.imgur.com/FwhbBQB.png)

And we're done! Let's talk about drawbacks.

# Drawbacks
The biggest drawback for this workflow is that when in Xcode you won't be able to see the changes you make to your views until you run your app. Fixing that issue specifically is a whole other can of worms. Though the future of this project isn't to work with UI inside of Xcode. The future of this project is to export your designs directly from Sketch, or a similar design program. That way we keep our design and our code separate. This of course has it's own positives and negatives but for my projects, that is the workflow I am working towards.

Another drawback you may be thinking about is rotating an iPhone screen. Though for this project, a lot of the apps I have created, and even most the apps I use on a daily basis don't rotate at all. This is an issue I'm experimenting with but it's not a huge deal for me at the moment.

The third biggest drawback would be animation. I've been experimenting with this more recently and I can see it not being to hard to implement a quality animation library. We'll save that for another post though.

Despite these drawbacks, I believe there are ways to get around them and I believe they aren't a critical issue at this time. 

# Conclusion
To conclude, this is a new way of creating UI that I have been experimenting with. The next steps are refining the classes and giving a bit more flexibility with what you can do with them. I'm very happy with where things are now though and these concepts are at a base state where I can use them sparingly in my projects where performance is key.

Speaking of performance, I never spoke about performance. Mainly because I don't have a good way to test the speed of UI but there are obvious performance benefits to not using AutoLayout. If you have a way, please let me know!

If you would like to see this workflow in an actual app check out my apps [Kibbl](https://itunes.apple.com/us/app/kibbl/id1241433983?ls=1&mt=8) and the [Software Engineering Daily Podcast App](https://itunes.apple.com/us/app/software-engineering-daily-podcast-app/id1253734426?ls=1&mt=8).

That's about it though! Thank you so much for reading. Please let me know what you think by commenting on this post or sending me a message through social media(see below). If you have something to contribute to this project, please visit the [Github repo](https://github.com/KoalaTeaCode/KTInstagramUIExampleProject).

The KoalaTea Github: https://github.com/KoalaTeaCode

My Twitter: https://twitter.com/TheMrHolliday

My Reddit: https://www.reddit.com/user/Misterholliday/

[@TODO: INSERT NEWSLETTER LINK HERE]