//
//  MBTraitCollection.h
//
//  Copyright (c) 2015 Matej Balantic. All rights reserved.
//

@import UIKit;


@interface MBTraitCollection : NSObject

@property (nonatomic, readonly) UIUserInterfaceIdiom userInterfaceIdiom;
@property (nonatomic, readonly) UIUserInterfaceSizeClass horizontalSizeClass;
@property (nonatomic, readonly) UIUserInterfaceSizeClass verticalSizeClass;
@property (nonatomic, readonly) CGFloat displayScale;

+(instancetype)traitCollectionWithViewController:(UIViewController *)viewController;

@end
