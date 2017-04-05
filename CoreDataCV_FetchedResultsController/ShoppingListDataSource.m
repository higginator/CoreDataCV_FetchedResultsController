//
//  ShoppingListDataSource.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "ShoppingListDataSource.h"
#import "ShoppingListCell.h"
#import "ShoppingItem.h"
#import "WebService.h"
#import "Store.h"

@interface ShoppingListDataSource ()

@property (nonatomic, weak) NSFetchedResultsController *frc;

@end

@implementation ShoppingListDataSource



- (instancetype)initWithFRC:(NSFetchedResultsController *)frc {
    self = [super init];
    if (self) {
        _frc = frc;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.frc.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.frc.sections[section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    ShoppingItem *shoppingItem = [self.frc objectAtIndexPath:indexPath];
    [self configureCell:cell withItem:shoppingItem];
    cell.backgroundColor = [self randomColor];
    return cell;
}

- (void)configureCell:(ShoppingListCell *)cell withItem:(ShoppingItem *)item {
    cell.label.text = item.label;
    cell.total.text = [NSString stringWithFormat:@"%lld", item.total];
    // After creating ShoppingItem managedobjects, erroring when accessing
    // webService relationship
    cell.webServiceLabel.text = item.webService.label;
    cell.storeLabel.text = item.store.label;
}

- (UIColor *)randomColor {
    CGFloat hue = arc4random() % 256 / 256.0;
    CGFloat sat = arc4random() % 128 / 256.0 + 0.5;
    CGFloat bri = arc4random() % 128 / 256.0 + 0.5;
    return [UIColor colorWithHue:hue saturation:sat brightness:bri alpha:1.0];
}

@end
