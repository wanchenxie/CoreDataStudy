//
//  ViewController.h
//  CoreDataStudy
//
//  Created by wanchenxie on 08/03/2017.
//  Copyright © 2017 wanchenxie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Add this property for core data. this property was setted by AppDelegate
@property (nonatomic, weak) NSManagedObjectContext* context;

@end

