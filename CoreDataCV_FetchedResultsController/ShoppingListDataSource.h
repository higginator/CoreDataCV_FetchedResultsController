//
//  ShoppingListDataSource.h
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ShoppingListDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithFRC:(NSFetchedResultsController *)frc;

@end
