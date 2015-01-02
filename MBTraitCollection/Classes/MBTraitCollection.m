//
//  MBTraitCollection.m
//
//  Copyright (c) 2015 Matej Balantic. All rights reserved.
//

#import "MBTraitCollection.h"

@interface MBTraitCollection ()
@property (weak) UIViewController *viewController;
@end

@implementation MBTraitCollection

#pragma mark - Initializers

+ (instancetype)traitCollectionWithViewController:(UIViewController *)viewController
{
    return [[self.class alloc] initWithViewController:viewController];
}

- (id)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        NSParameterAssert(viewController);
        self.viewController = viewController;
    }
    return self;
}

#pragma mark - Public

-(UIUserInterfaceIdiom)userInterfaceIdiom
{
    if ([self isNativeTraitCollectionAvailable]) {
        return self.traitCollection.userInterfaceIdiom;
    }

    return UI_USER_INTERFACE_IDIOM();
}

- (UIUserInterfaceSizeClass)verticalSizeClass
{
    if ([self isNativeTraitCollectionAvailable]) {
        return self.traitCollection.verticalSizeClass;
    }

    return [self isVerticalSizeClassCompact] ? UIUserInterfaceSizeClassCompact : UIUserInterfaceSizeClassRegular;
}

- (UIUserInterfaceSizeClass)horizontalSizeClass
{
    if ([self isNativeTraitCollectionAvailable]) {
        return self.traitCollection.horizontalSizeClass;
    }

    return [self isHorizontalSizeClassCompact] ? UIUserInterfaceSizeClassCompact : UIUserInterfaceSizeClassRegular;
}

- (CGFloat)displayScale
{
    if ([self isNativeTraitCollectionAvailable]) {
        return self.traitCollection.displayScale;
    }

    return [[UIScreen mainScreen] scale];
}

#pragma mark - Private

- (BOOL)isNativeTraitCollectionAvailable
{
    return (BOOL)[self traitCollection];
}

-(UITraitCollection *)traitCollection
{
    if ([self.viewController respondsToSelector:@selector(traitCollection)]) {
        return self.viewController.traitCollection;
    }

    return nil;
}

- (BOOL)isVerticalSizeClassCompact
{
    return self.userInterfaceIdiom == UIUserInterfaceIdiomPhone && UIInterfaceOrientationIsLandscape(self.viewController.interfaceOrientation);
}

- (BOOL)isHorizontalSizeClassCompact
{
    return self.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

@end
