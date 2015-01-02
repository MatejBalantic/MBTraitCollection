//
//  ViewController.m
//  MBTraitCollection
//
//  Copyright (c) 2015 Matej Balantic. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MBTraitCollection.h"

@interface ViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

#pragma mark - Constants

static NSString *const kCellIdentifier = @"cell";

#pragma mark - UIView

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewControllerDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self detailForRow:indexPath.row];

    return cell;
}

#pragma mark - Private

- (NSString *)titleForRow:(NSInteger)row
{
    switch (row) {
        default:
        case 0: return @"Vertical size class";
        case 1: return @"Horizontal size class";
        case 2: return @"Display scale";
        case 3: return @"User interface idiom";
    }
}

- (NSString *)detailForRow:(NSInteger)row
{
    switch (row) {
        default:
        case 0: return [self sizeClassAsString:self.mbTraitCollection.verticalSizeClass];
        case 1: return [self sizeClassAsString:self.mbTraitCollection.horizontalSizeClass];
        case 2: return [NSString stringWithFormat:@"%f", self.mbTraitCollection.displayScale];
        case 3: return [self idiomAsString:self.mbTraitCollection.userInterfaceIdiom];
    }
}

- (NSString *)sizeClassAsString:(UIUserInterfaceSizeClass)sizeClass
{
    NSParameterAssert(sizeClass != UIUserInterfaceSizeClassUnspecified);
    return sizeClass == UIUserInterfaceSizeClassCompact ? @"compact" : @"regular";
}

- (NSString *)idiomAsString:(UIUserInterfaceIdiom)idiom
{
    NSParameterAssert(idiom != UIUserInterfaceIdiomUnspecified);

    return idiom == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone";
}

@end
