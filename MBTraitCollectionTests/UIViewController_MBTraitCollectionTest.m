@import UIKit;

#define EXP_SHORTHAND
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "UIViewController+MBTraitCollection.h"

SpecBegin(MBTraitCollection_UIViewController)

__block UIViewController *subject;

before(^{
    subject = [[UIViewController alloc] init];
});

describe(@"-mbTraitCollection", ^{
    context(@"first time called", ^{
        it(@"returns a new instance of MBTraitCollection", ^{
            expect(subject.mbTraitCollection).to.beInstanceOf(MBTraitCollection.class);
        });
    });

    context(@"called more than once", ^{
        __block MBTraitCollection *traitCollection;

        before(^{
            traitCollection = subject.mbTraitCollection;
        });

        it(@"returns the same instance every time", ^{
            expect(subject.mbTraitCollection).to.beIdenticalTo(traitCollection);
        });
    });
});

SpecEnd