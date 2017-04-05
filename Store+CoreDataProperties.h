//
//  Store+CoreDataProperties.h
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "Store.h"


NS_ASSUME_NONNULL_BEGIN

@interface Store (CoreDataProperties)

+ (NSFetchRequest<Store *> *)fetchRequest;

@property (nonatomic) int64_t priority;
@property (nullable, nonatomic, copy) NSString *label;
@property (nullable, nonatomic, retain) ShoppingItem *shoppingItem;

@end

NS_ASSUME_NONNULL_END
