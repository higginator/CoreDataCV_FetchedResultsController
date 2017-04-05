//
//  ShoppingItem+CoreDataProperties.h
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "ShoppingItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShoppingItem (CoreDataProperties)

+ (NSFetchRequest<ShoppingItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *label;
@property (nonatomic) int64_t total;
@property (nullable, nonatomic, retain) Store *store;
@property (nullable, nonatomic, retain) WebService *webService;

@end

NS_ASSUME_NONNULL_END
