//
//  DataController.m
//  CoreDataCV_FetchedResultsController
//
//  Created by Ryan Higgins on 4/5/17.
//  Copyright © 2017 Ryan Higgins. All rights reserved.
//

#import "DataController.h"

@interface DataController ()

@property (nonatomic, strong) NSManagedObjectContext *privateMOC;

@end

@implementation DataController

- (instancetype)init {
    if (self) {
        [self setupCoreData];
    }
    return self;
}

#pragma mark - Core Data

- (void)setupCoreData {
    // setup model
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[self modelURL]];
    
    // setup psc
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // setup contexts
    NSManagedObjectContext *mainMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    NSManagedObjectContext *privateMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    mainMOC.parentContext = privateMOC;
    [privateMOC setPersistentStoreCoordinator:psc];
    self.mainMOC = mainMOC;
    self.privateMOC = privateMOC;
    
    // setup persistent store. Use non-main thread, store might need to perform
    // time-consuming migrations and network requests.
    dispatch_queue_t queue;
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        NSError *error;
        NSMutableDictionary *storeOptions = [[NSMutableDictionary alloc] init];
        [storeOptions setValue:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
        [storeOptions setValue:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
        NSPersistentStore *store = nil;
        store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:[self persistentStoreURL]
                                        options:storeOptions
                                          error:&error];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self updateUI];
        });
    });
}

- (void)saveContext {
    // pass changes from main thread to private thread
    
    [self.mainMOC performBlockAndWait:^{
        if (![self.mainMOC hasChanges]) { return; }
        NSError *error;
        if (![self.mainMOC save:&error]) {
            NSLog(@"mainMOC unable to save");
        } else {
            NSLog(@"mainMOC saved");
        }
    }];
    [self.privateMOC performBlock:^{
        if (![self.privateMOC hasChanges]) { return; }
        NSError *error;
        if (![self.privateMOC save:&error]) {
            NSLog(@"privateMOC unable to save");
        } else {
            NSLog(@"privateMOC saved");
        }
    }];
}

#pragma mark - URL Paths

- (NSURL *)modelURL {
    return [[NSBundle mainBundle] URLForResource:@"ShoppingList" withExtension:@"momd"];
}

- (NSURL *)persistentStoreURL {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *documents = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [documents lastObject];
    return [documentsURL URLByAppendingPathComponent:@"ShoppingList.sqlite"];
}

#pragma mark - UI

- (void)updateUI {
    NSLog(@"persistent store setup.");
    [[NSNotificationCenter defaultCenter]
     postNotification:[NSNotification notificationWithName:@"LoadRootVC"
                                                    object:nil]];
}

@end
