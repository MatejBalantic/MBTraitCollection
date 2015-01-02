//
//  UIViewController+MBTraitCollection.m
//
//  Copyright (c) 2015 Matej Balantic. All rights reserved.
//

@import ObjectiveC;

#import "UIViewController+MBTraitCollection.h"

@implementation UIViewController (MBTraitCollection)

- (MBTraitCollection *)mbTraitCollection
{
    SEL key = @selector(mbTraitCollection);

    MBTraitCollection *traitCollection = objc_getAssociatedObject(self, key);

    if (traitCollection == nil) {
        traitCollection = [MBTraitCollection traitCollectionWithViewController:self];
        objc_setAssociatedObject(self, key, traitCollection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return traitCollection;
}

@end
