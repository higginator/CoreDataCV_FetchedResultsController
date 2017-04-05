//
//  ShoppingItem+CoreDataProperties.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "ShoppingItem+CoreDataProperties.h"

@implementation ShoppingItem (CoreDataProperties)

+ (NSFetchRequest<ShoppingItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShoppingItem"];
}

@dynamic label;
@dynamic total;
@dynamic store;
@dynamic webService;

@end
