//
//  ShoppingListCell.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "ShoppingListCell.h"

@implementation ShoppingListCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentViewSubviews];
    }
    return self;
}

#pragma mark - Cell ContentView subviews

- (void)setupContentViewSubviews {
    [self setupLabelFrame];
    [self setupTotalFrame];
    [self setupWebServiceLabelFrame];
    [self setupStoreLabelFrame];
}

- (void)setupLabelFrame {
    // Add label
    CGRect labelFrame = CGRectMake(0, 10, self.frame.size.width, 40);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    [self.contentView addSubview:label];
    self.label = label;
}

- (void)setupTotalFrame {
    CGRect totalFrame = CGRectMake(0, 50, self.frame.size.width, 40);
    UILabel *total = [[UILabel alloc] initWithFrame:totalFrame];
    [self.contentView addSubview:total];
    self.total = total;
}

- (void)setupWebServiceLabelFrame {
    CGRect webServiceFrame = CGRectMake(0, 90, self.frame.size.width, 40);
    UILabel *webService = [[UILabel alloc] initWithFrame:webServiceFrame];
    [self.contentView addSubview:webService];
    self.webServiceLabel = webService;
}

- (void)setupStoreLabelFrame {
    CGRect storeFrame = CGRectMake(0, 130, self.frame.size.width, 40);
    UILabel *store = [[UILabel alloc] initWithFrame:storeFrame];
    [self.contentView addSubview:store];
    self.storeLabel = store;
}

@end
