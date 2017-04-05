//
//  WebService+CoreDataProperties.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "WebService+CoreDataProperties.h"

@implementation WebService (CoreDataProperties)

+ (NSFetchRequest<WebService *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WebService"];
}

@dynamic domain;
@dynamic priority;
@dynamic label;
@dynamic shoppingItem;

@end
