//
//  AppDelegate.m
//  CoreDataStudy
//
//  Created by wanchenxie on 08/03/2017.
//  Copyright © 2017 wanchenxie. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

// Property for Core Data
@property (readwrite, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    // Abtain the current view and set its managed object context
    ViewController* vc = (ViewController*)self.window.rootViewController;
    vc.context = self.managedObjectContext;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack
- (NSManagedObjectModel*)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL* modelUrl = [[NSBundle mainBundle] URLForResource:@"CoreDataStudy" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    }
    
    return  _managedObjectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        // Store path for Core Data
        NSURL* docUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSURL* cdUrl = [docUrl URLByAppendingPathComponent:@"coreData.sqlite"];
        
        // Create a coordinator
        NSError* err;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                             configuration:nil
                                                                                       URL:cdUrl
                                                                                   options:nil error:&err];
        NSAssert3(store != nil, @"Unhandled error adding persistent store in %s at line %d %@", __FUNCTION__, __LINE__, [err localizedDescription]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext*)managedObjectContext {
    if (_managedObjectContext == nil) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
