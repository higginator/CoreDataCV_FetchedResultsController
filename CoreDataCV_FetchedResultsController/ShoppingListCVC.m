//
//  ShoppingListCVC.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "ShoppingListCVC.h"
#import "ShoppingListDelegate.h"
#import "ShoppingListDataSource.h"
#import "ShoppingListCell.h"
#import <CoreData/CoreData.h>

// Imports for accessing DataController
#import "AppDelegate.h"
#import "DataController.h"

// Imports for creating CoreData Managed Objects
#import "ShoppingItem.h"
#import "WebService.h"
#import "Store.h"

@interface ShoppingListCVC () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) ShoppingListDelegate *delegate;
@property (nonatomic, strong) ShoppingListDataSource *dataSource;
@property (nonatomic, strong) NSFetchedResultsController *frc;

@end

@implementation ShoppingListCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self setupFetchedResultsController];
        _delegate = [[ShoppingListDelegate alloc] init];
        _dataSource = [[ShoppingListDataSource alloc] initWithFRC:self.frc];
        self.collectionView.delegate = self.delegate;
        self.collectionView.dataSource = self.dataSource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blueColor];
    // Register cell classes
    [self.collectionView registerClass:[ShoppingListCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Item" style:UIBarButtonItemStylePlain target:self action:@selector(addShoppingItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)addShoppingItem {
    // ManagedObject Attributes
    ShoppingItem *shoppingItem =
    [NSEntityDescription insertNewObjectForEntityForName:@"ShoppingItem"
                                  inManagedObjectContext:[self dataController].mainMOC];
    shoppingItem.total = 3;
    shoppingItem.label = @"Markers";
    
    WebService *webService =
    [NSEntityDescription insertNewObjectForEntityForName:@"WebService"
                                  inManagedObjectContext:[self dataController].mainMOC];
    webService.label = @"Amazon";
    webService.domain = @"https://www.amazon.com";
    webService.priority = 2;
    
    Store *store =
    [NSEntityDescription insertNewObjectForEntityForName:@"Store"
                                  inManagedObjectContext:[self dataController].mainMOC];
    store.label = @"Target";
    store.priority = 1;
    
    // ManagedObject Relationships
    shoppingItem.webService = webService;
    shoppingItem.store = store;
    webService.shoppingItem = shoppingItem;
    store.shoppingItem = shoppingItem;
    
    [[self dataController] saveContext];
}

- (DataController *)dataController {
    AppDelegate *delegate =
    (AppDelegate *)[UIApplication sharedApplication].delegate;
    DataController *dataController = [delegate.allViewControllers objectForKey:@"DataController"];
    return dataController;
}

- (void)setupFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest
                               fetchRequestWithEntityName:@"ShoppingItem"];
    NSSortDescriptor *sort = [NSSortDescriptor
                              sortDescriptorWithKey:@"label" ascending:YES];
    [request setSortDescriptors:@[sort]];
    [request setIncludesSubentities:YES];
    NSManagedObjectContext *mainMOC = [self dataController].mainMOC;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:mainMOC sectionNameKeyPath:nil cacheName:nil];
    self.frc = frc;
    self.frc.delegate = self;
    
    // populate frc with data
    NSError *error;
    [self.frc performFetch:&error];
    if (error) {
        NSLog(@"frc error fetching: %@", [error localizedDescription]);
    } else {
        NSLog(@"frc fetch succeeded");
        NSLog(@"number of fetch objects: %ld", [self.frc.sections[0] numberOfObjects]);
        NSLog(@"fetch objects: %@", [self.frc.sections[0] objects]);
    }
}

#pragma mark - Fetched Results Controller Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    //NSLog(@"will change content");
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSLog(@"did change object");
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
            break;
        
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //NSLog(@"did change content");
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    //NSLog(@"did change section");
}































@end
