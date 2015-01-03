[![Build Status](https://travis-ci.org/MatejBalantic/MBTraitCollection.svg)](1)

MBTraitCollection
=================

UIViewController category that provides safe iOS7 compatible access to UITraitCollection object by exposing new property ``mbTraitCollection`` on a UIViewController.


## How can I use MBTraitCollection

Add this line to your project `Podfile`
```pods
  pod 'MBTraitCollection', '~> 0.1.0'
```

Than, include it in your view controller and use it on >=iOS 7 targets

```obj-c
#import <MBTraitCollection/UIViewController+MBTraitCollection.h>

@implementation MyViewController

-(void)myMethod
{
  if (self.mbTraitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
    // ...
  }
}

@end
```

## tl;dr: The background

### What is a Trait Collection

From [Apple Docs][2]: _A UITraitCollection object provides details about the characteristics of a UIViewController object, which manages a set of views that make up a portion of your app’s interface. These characteristics, or traits, define the size class, display scale, and device idiom of the view controller. When a view controller is created, a trait collection is automatically created for that view controller._

### What are Trait collections good for

Trait collections are great as they provide easy access to device characteristics without need to know the exact device make or model. Trait collections can be used as a clean way to programmatically differentiate your app's behavior on different kinds of devices, without hard-coding device type or size. So, **instead of something like this**:

```obj-c
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  // iphone
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone()) {
    // iphone 6 landscape
    if ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 736.0f
    && UIInterfaceOrientationIsLandscape(self.interfaceOrientation))  {
      return CGSizeMake(100, 100);
    }
    
    // all other iphones
    return CGSizeMake(50, 50);
  }
  
  // ipads
  else {
    return CGSizeMake(100, 100);
  }
}
```

you **can get away with much cleaner and future-proof solution**:

```obj-c
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.mbTraitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
    return CGSizeMake(50, 50);
  }
  else {
    return CGSizeMake(100, 100);
  }
}
```

Generally trait will provide you with access to these 4 very usefull properties:
* `userInterfaceIdiom`
* `horizontalSizeClass`
* `verticalSizeClass`
* `displayScale`

### The problem

Trait collections are new as of iOS 8 and even if they compile with the latest SDK even for deployment targets older than 8.0, their use will cause crash in iOS 7 application. This renders them unusefull until application deployment target is restricted to 8.0. 

### Solution : MBTraitCollection

To solve that problem, I've created a category on UIViewController which exposes a new property `mbTraitCollection`. When accessing this property a backwards-compatible MBTraitCollection class will be lazy-loaded for you. Class is basically a wrapper around UITraitCollection and will use native behavior when possible (i.e. in iOS >= 8). On older iOS version, this class will use other available techniques to determine device characteristics for you, thus allowing you to use trait collection even on iOS 7.


[1]: https://travis-ci.org/MatejBalantic/MBTraitCollection
[2]: https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UITraitSet_ClassReference/index.html
