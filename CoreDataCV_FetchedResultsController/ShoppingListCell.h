//
//  ShoppingListCell.h
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *total;
@property (nonatomic, strong) UILabel *webServiceLabel;
@property (nonatomic, strong) UILabel *storeLabel;

@end
