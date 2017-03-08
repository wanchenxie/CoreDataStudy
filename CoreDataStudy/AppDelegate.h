//
//  AppDelegate.h
//  CoreDataStudy
//
//  Created by wanchenxie on 08/03/2017.
//  Copyright © 2017 wanchenxie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

