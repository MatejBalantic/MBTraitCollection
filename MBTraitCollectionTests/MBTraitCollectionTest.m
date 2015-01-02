@import UIKit;

#define EXP_SHORTHAND
#define MOCKITO_SHORTHAND

#import <Specta/Specta.h>
#import <OCMockito/OCMockito.h>
#import <Expecta/Expecta.h>
#import "MBTraitCollection.h"

SpecBegin(MBTraitCollection)

__block MBTraitCollection *subject;
__block UIViewController *viewController;
__block UITraitCollection *traitCollection;
__block BOOL (^nativeTraitCollectionSupported)();

before(^{
    nativeTraitCollectionSupported = ^BOOL() {
        return [[[UIViewController alloc] init] respondsToSelector:@selector(traitCollection)];
    };

    viewController = mock(UIViewController.class);

    if (nativeTraitCollectionSupported()) {
        traitCollection = [UITraitCollection traitCollectionWithTraitsFromCollections:@[
             [UITraitCollection traitCollectionWithDisplayScale:2.0],
             [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact],
             [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact],
             [UITraitCollection traitCollectionWithUserInterfaceIdiom:UIUserInterfaceIdiomPhone]
        ]];

        [given([viewController traitCollection]) willReturn:traitCollection];
    }

    subject = [MBTraitCollection traitCollectionWithViewController:viewController];
});

describe(@"+traitCollectionWithViewController:", ^{
    context(@"called without view controller", ^{
        it(@"raises an assertion", ^{
            expect(^{ [MBTraitCollection traitCollectionWithViewController:nil];  }).to.raiseAny();
        });
    });

    context(@"called with view controller", ^{
        it(@"returns instance of MBTraitCollection", ^{
            expect([MBTraitCollection traitCollectionWithViewController:viewController]).to.beInstanceOf(MBTraitCollection.class);
        });
    });
});

describe(@"-userInterfaceIdiom", ^{
    it(@"returns the user interface idiom", ^{
        UIUserInterfaceIdiom idiom = [subject userInterfaceIdiom];
        UIUserInterfaceIdiom expectedIdiom;

        if (nativeTraitCollectionSupported()) {
            expectedIdiom = viewController.traitCollection.userInterfaceIdiom;
        } else {
            expectedIdiom = UI_USER_INTERFACE_IDIOM();
        }

        expect(idiom).to.equal(expectedIdiom);
    });
});

describe(@"-displayScale", ^{
    it(@"returns the display scale", ^{
        CGFloat displayScale = [subject displayScale];
        CGFloat expectedScale;
        if (nativeTraitCollectionSupported()) {
            expectedScale = viewController.traitCollection.displayScale;
        } else {
            expectedScale = [[UIScreen mainScreen] scale];
        }

        expect(displayScale).to.equal(expectedScale);
    });
});

describe(@"-horizontalSizeClass", ^{
    it(@"returns the horizontal size class", ^{
        UIUserInterfaceSizeClass sizeClass = [subject horizontalSizeClass];
        UIUserInterfaceSizeClass expectedSizeClass;

        if (nativeTraitCollectionSupported()) {
            expectedSizeClass = viewController.traitCollection.horizontalSizeClass;
        } else {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                expectedSizeClass = UIUserInterfaceSizeClassCompact;
            } else {
                expectedSizeClass = UIUserInterfaceSizeClassRegular;
            }
        }

        expect(sizeClass).to.equal(expectedSizeClass);
    });
});

describe(@"-verticalSizeClass", ^{
    context(@"view controller orientation is landscape", ^{
        before(^{
            [given([viewController interfaceOrientation]) willReturnInt:UIInterfaceOrientationLandscapeLeft];
        });

        it(@"returns the vertical size class", ^{
            UIUserInterfaceSizeClass sizeClass = [subject verticalSizeClass];
            UIUserInterfaceSizeClass expectedSizeClass;

            if (nativeTraitCollectionSupported()) {
                expectedSizeClass = viewController.traitCollection.verticalSizeClass;
            } else {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    expectedSizeClass = UIUserInterfaceSizeClassCompact;
                } else {
                    expectedSizeClass = UIUserInterfaceSizeClassRegular;
                }
            }
            
            expect(sizeClass).to.equal(expectedSizeClass);
        });
    });

    context(@"view controller orientation is portrait", ^{
        before(^{
            [given([viewController interfaceOrientation]) willReturnInt:UIInterfaceOrientationMaskPortrait];
        });

        it(@"returns the vertical size class", ^{
            UIUserInterfaceSizeClass sizeClass = [subject verticalSizeClass];
            UIUserInterfaceSizeClass expectedSizeClass;

            if (nativeTraitCollectionSupported()) {
                expectedSizeClass = viewController.traitCollection.verticalSizeClass;
            } else {
                expectedSizeClass = UIUserInterfaceSizeClassRegular;
            }

            expect(sizeClass).to.equal(expectedSizeClass);
        });
    });
});

SpecEnd