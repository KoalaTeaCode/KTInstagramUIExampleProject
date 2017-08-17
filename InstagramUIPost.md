* A note: All of the concepts in this post are about creating views programmatically. I do not use Storyboards at all in my projects and therefore do not create views or layout constraints from the interface builder.

Table of Contents:
- [INTRO](#intro)
- [ISSUES WITH AUTOLAYOUT](#issues-with-autolayout)
- [Extensions & Math](#extensions-math)
- [The make up of a view frame](#the-make-up-of-a-view-frame)
- [Sketch design](#sketch-design)
- [Coding the views](#coding-the-views)
    - [Coding the Top Bar](#coding-the-top-bar)
    - [Coding the Button View](#coding-the-button-view)
    - [Coding the Comments View](#coding-the-comments-view)
    - [Putting it all together](#putting-it-all-together)
- [Drawbacks](#drawbacks)
- [Conclusion](#conclusion)


# INTRO

Hello dear reader!

The other day as I was perusing reddit, I came across a post called something along the lines of "The case against AutoLayout". The post linked to an issue on the [IGList Github repo](https://github.com/Instagram/IGListKit), where Ryan Nystrom, a developer for Instagram, said ["Instagram doesn't use self-sizing-cells or auto layout at all"](https://github.com/Instagram/IGListKit/issues/508). This made me start thinking. I neither love nor hate AutoLayout but I've also never believed there was a different way to create views, and I certainly didn't think that a company as big as Instagram would shy away from the industry standard that is AutoLayout. 

After researching and testing a few ways to create UI without AutoLayout, I believe I have found at least a solid starting point. Today we'll go over the basics and I'll show you how I got from a design in Sketch straight to Xcode using math and not a single AutoLayout constraint.

I will go over some of my issues with AutoLayout, explain some of the math and view extensions we'll be using, go over our Sketch design, and finally start writing the code in our project. If you'd like to skip to a specific section, please see the table of contents above. Also you can just go straight to the [Github repo](https://github.com/KoalaTeaCode/KTInstagramUIExampleProject) for the full project.

# ISSUES WITH AUTOLAYOUT

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

All of my apps are for iPhone and iPad because why not? None of my apps are made just for one screen size or use anything specific to just an iPhone so the only barrier is my UI. AutoLayout is supposed to bridge this gap, but say if when setting up my layout I set an inset of 10 for the left side of my view:
```swift
myView.snp.makeConstraints { (make) -> Void in
    make.left.equalToSuperview().inset(10)
    make.right.equalToSuperview()
}
```
Well when I launch my app on the iPad simulator, the inset will still be 10 but the iPad has a much larger screen size. This leads to odd looking views that have been stretched instead of scaled proportionally. 

These issues can seem small but they start to snowball when you're working on a project for a long time, working on multiple projects, or trying to get a UI design from Sketch exactly right to balance your designer's temperament.

If you have no issue with AutoLayout, feel free to read this simply as a discussion about a different way to create UI and not a statement about the right or wrong way to create UI because there is none.

# Extensions & Math
Before we start creating views, we need two custom extension to help calculate the height, width, and position for our views when they are being scaled for different devices. These two extensions:

```swift
let iphone7Height: CGFloat = 667.0
let iphone7Width: CGFloat = 375.0

extension Int {
    func calculateHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

// Extensions in use
let calculatedWidth = 50.calculateWidth()
let calculatedHeight = 50.calculateHeight()
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

# Sketch design
For the actual view we will recreate in Xcode, I have chosen the Post view from Instagram. This is a post I made of my puppy Bandit growing up way too fast. The design is simple and with this we can see how Instagram would not use AutoLayout at all in their app.

I won't go too in-depth into Sketch or our design. You can examine the image below and see that I have used a plugin called [SketchMeasure](http://utom.design/measure/) to measure the height, width, and distance between views for every part of our design. You will be able to see pretty easily how knowing all these measurements will help us in coding the views.

![Full Design](http://i.imgur.com/N8Erfbp.png)

# Coding the views
Finally! Let's stop talking about concepts and get down to the code. 

## Coding the Top Bar
![Top Bar View](http://i.imgur.com/nCo0VGf.png)

Create a new Swift file or create a UIView and call it "TopBarView". Then we'll create the class and add all our views. You can initialize them here or make the views optional and initialize them later, either works.
```swift
import UIKit

class TopBarView: UIView {
    let userImageView = UIImageView()
    let userLabel = UILabel()
    let ellipsesImageView = UIImageView()
}
```
We'll also need to add two methods to initialize this class:
```swift
override init(frame: CGRect) {
    super.init(frame: frame)
}
    
required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```
In our init method, we'll start with the userImageView which contains our user's image(go figure). Since we already initialized our view all we need to do is set the frame. We'll also make the view circular and add an image.
```swift
userImageView.frame = CGRect(x: 10.calculateWidth(), y: 10.calculateHeight(), width: 32.calculateHeight(), height: 32.calculateHeight())

userImageView.layer.cornerRadius = userImageView.frame.height / 2

userImageView.clipsToBounds = true

userImageView.image = #imageLiteral(resourceName: "userImage")

self.addSubview(userImageView)
```
The view will be 10px from the top and 10px from the left of the superview which is the class we're creating now. Also we set the width and height BOTH to 32.calculateHeight() because this view will need to be a circle and if we calculate the width and height separately we will get more of an oval on different views.

Then we set our corner radius to be the height of the userImageView divided by 2. That will round the view.

We have to set .clipsToBounds to true so that when we add an image it will be masked out and not extend beyond our circular view.

Then we add our image. I'm using an "Image Literal" because I have the asset inside of my project and you can just call the asset by name inside your project.

Finally we have to add our completed view as a subview to our TopBarView class.

Moving on to the userLabel which will contain the username of our user. Here's the code: 
```swift
...
userLabel.frame = CGRect(x: 52.calculateWidth(), y: 10.calculateHeight(), width: 284.calculateWidth(), height: 32.calculateHeight())

userLabel.text = "themisterholliday"

userLabel.font = UIFont.systemFont(ofSize: 15.calculateWidth())

self.addSubview(userLabel)
```

We set our frame just as before. Again we are setting a 10px inset from the top of the superview and instead of snapping our userLabel to the right of our userImageView we use an inset of 52.

Then we set the text and can scale the font by using our calculateWidth extension.

**Side note:** We could easily calculate the inset from the right side of the userImageView like so:
```swift
userLabel.frame = CGRect(x: userImageView.frame.maxX + 10.calculateWidth(), y: 10.calculateHeight(), width: 284.calculateWidth(), height: 32.calculateHeight())
```
The inset is 10 from the right side of the userImageView which we can find by using "userImageView.frame.maxX".

And we're finished with the TopBarView.

## Coding the Button View
![Button View](http://i.imgur.com/Hcf6MSf.png)

* For the Button View we don't do anything too crazy, so I'm just going to throw the code for the class up here.
```swift
import UIKit

class ButtonView: UIView {
    let heartButton = UIButton()
    let commentButton = UIButton()
    let shareButton = UIButton()
    let bookmarkButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Heart Button
        heartButton.frame = CGRect(x: 14.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        heartButton.setImage(#imageLiteral(resourceName: "Heart"), for: .normal)
        heartButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(heartButton)
        
        // Comment Button
        commentButton.frame = CGRect(x: 55.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        commentButton.setImage(#imageLiteral(resourceName: "Comment"), for: .normal)
        commentButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(commentButton)
        
        // Share Button
        shareButton.frame = CGRect(x: 94.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        shareButton.setImage(#imageLiteral(resourceName: "Message"), for: .normal)
        shareButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(shareButton)
        
        // Bookmark Button
        bookmarkButton.frame = CGRect(x: 343.calculateWidth(), y: 13.calculateHeight(), width: 24.calculateWidth(), height: 22.calculateHeight())
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark"), for: .normal)
        bookmarkButton.imageView?.contentMode = .scaleAspectFit
        self.addSubview(bookmarkButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```
## Coding the Comments View
![Comments View](http://i.imgur.com/g5TdKV1.png)

The comments view isn't super complicated but we do a few new concepts that I'll cover. But of course every view starts the same.
```swift
import UIKit

class CommentsView: UIView {

    var likeLabel: UILabel!
    
    var descriptionLabel: UILabel!
    var moreLabel: UILabel!
    
    var viewAllCommentsLabel: UILabel!
    
    var timeLabel: UILabel!
}
```
To show something a little different, all of these labels are optional, so we will initialize them in our init method.

Our init method looks the same as the rest of our views:
```swift
override init(frame: CGRect) {
    super.init(frame: frame)
}
    
required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```

In our init method we will start with our first label:
```swift
let labelsWidth = self.frame.width - (16.calculateWidth() * 2)
        
likeLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: 0, width: labelsWidth, height: 18.calculateHeight()))
let likesCount = 287
let likesString = "likes"

likeLabel.font = UIFont.boldSystemFont(ofSize: 15.calculateHeight())
likeLabel.text = String(likesCount) + " " + likesString
self.addSubview(likeLabel)
```

We create a variable called "labelsWidth" because all our labels will have the same width. If you look at the Sketch design you can see that there is a 16px inset on both sides of each label so we just multiply 16 with a calculated width by 2 and subtract the total frame width by the outcome.

Next we create our description label:
```swift
descriptionLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: likeLabel.frame.maxY, width: labelsWidth, height: 42.calculateHeight()))
let username = "themisterholliday"
let description = "Hey this is an awesome description"

descriptionLabel.numberOfLines = 0

let fullMutableString = NSMutableAttributedString()
let usernameMutableString = NSMutableAttributedString(
    string: username,
    attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15.calculateHeight())])
let spaceString = NSMutableAttributedString(string: " ")
let descMutableString = NSMutableAttributedString(
    string: description,
    attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15.calculateHeight())])
fullMutableString.append(usernameMutableString)
fullMutableString.append(spaceString)
fullMutableString.append(descMutableString)

descriptionLabel.attributedText = fullMutableString
self.addSubview(descriptionLabel)
```

We snap the description labels origin point to the bottom left of the likeLabel by using "likeLabel.frame.maxY", use the same width, and a height of 42. We also want the username to be bold for this label so we do a bit of fiddling around with attributed strings.

Our second to last label is the viewAllCommentsLabel. In the actual Instagram app, you can see the last comment that was made on that specific post but we're going to avoid that for now and I'll talk about why at the end. 

Here is the viewAllCommentsLabel code:
```swift
viewAllCommentsLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: descriptionLabel.frame.maxY, width: labelsWidth, height: 20.calculateHeight()))
viewAllCommentsLabel.text = "View all 5 comments"
viewAllCommentsLabel.font = UIFont.systemFont(ofSize: 14.calculateHeight())
self.addSubview(viewAllCommentsLabel)
```

Our last label is the timeLabel. Nothing complicated here:
```swift
timeLabel = UILabel(frame: CGRect(x: 16.calculateWidth(), y: viewAllCommentsLabel.frame.maxY, width: labelsWidth, height: 24.calculateHeight()))
timeLabel.text = "3 HOURS AGO"
timeLabel.font = UIFont.systemFont(ofSize: 11.calculateHeight())
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

Start out like we do:
```swift
import UIKit

class PostView: UIView {

    var topBarView: TopBarView!
    var postImageView: UIImageView!
    var buttonView: ButtonView!
    var commentsView: CommentsView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

You see that we skipped over the postImageView and that's only because it is simply an image and doesn't need to be a separate view.

Let's initialize all our views:
```swift
topBarView = TopBarView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 54.calculateHeight()))
self.addSubview(topBarView)

postImageView = UIImageView(frame: CGRect(x: 0, y: topBarView.frame.maxY, width: self.frame.width, height: self.frame.width))
postImageView.image = #imageLiteral(resourceName: "postImage")
self.addSubview(postImageView)

buttonView = ButtonView(frame: CGRect(x: 0, y: postImageView.frame.maxY, width: self.frame.width, height: 48.calculateHeight()))
self.addSubview(buttonView)

commentsView = CommentsView(frame: CGRect(x: 0, y: buttonView.frame.maxY, width: self.frame.width, height: 0))
self.addSubview(commentsView)
```

Hopefully by now you can tell what we're doing here by snapping every view to the bottom of the view before it.

And if we'd like to use this PostView in a view controller all we have to do is use it like this:
```swift
class ViewController: UIViewController {

    var postView: PostView!

    override func viewDidLoad() {
        super.viewDidLoad()
        postView = PostView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 960.calculateHeight()))
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
So the biggest drawback that you may be thinking about is rotating an iPhone screen. Though for this project, a lot of the apps I have created, and even most the apps I use on a daily basis don't rotate at all. This is an issue I'm experimenting with but it's not a huge deal for me at the moment.

The second biggest drawback would be animation. I haven't experimented a lot with different animations using this workflow but things would have to be rethought from the perspectives of constraints and more on the focus of a view's anchor point.

Despite these drawbacks, I believe there are ways to get around them and I believe they aren't a critical issue at this time. 

# Conclusion
To conclude, this is a very new way of create UI that I have been experimenting with. The next steps would probably write a few to shorten the amount of code that needs to be written. Especially with writing ".calculateWidth()" every width and height. I'll continue to work with this and use this workflow in a few of my projects. I would recommend using the extensions at the very least in tandem with AutoLayout to properly calculate constraints.

If you would like to see this workflow in an actual app check out my apps [Kibbl](https://itunes.apple.com/us/app/kibbl/id1241433983?ls=1&mt=8) and the [Software Engineering Daily Podcast App](https://itunes.apple.com/us/app/software-engineering-daily-podcast-app/id1253734426?ls=1&mt=8).

That's about it though! Thank you so much for reading. Please let me know what you think by commenting on this post or sending me a message through social media(see below). If you have something to contribute to this project, please visit the [Github repo](https://github.com/KoalaTeaCode/KTInstagramUIExampleProject).

The KoalaTea Github: https://github.com/KoalaTeaCode

My Twitter: https://twitter.com/TheMrHolliday

My Reddit: https://www.reddit.com/user/Misterholliday/

[INSERT NEWSLETTER LINK HERE]