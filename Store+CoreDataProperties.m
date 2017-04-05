//
//  Store+CoreDataProperties.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "Store+CoreDataProperties.h"

@implementation Store (CoreDataProperties)

+ (NSFetchRequest<Store *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Store"];
}

@dynamic priority;
@dynamic label;
@dynamic shoppingItem;

@end
