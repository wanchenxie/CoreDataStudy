//
//  ViewController.m
//  CoreDataStudy
//
//  Created by wanchenxie on 08/03/2017.
//  Copyright © 2017 wanchenxie. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

- (IBAction)screenTapped:(UIControl *)sender;

- (IBAction)saveBtnClicked:(UIButton *)sender;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create a request
    // The @"Line" string is the Entity's name and it is setted when your create the Entity.
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Line"];
    
    NSError* err;
    NSArray* objs = [self.context executeFetchRequest:request error:&err];
    if (objs == nil) {
        NSLog(@"Unhanled error in %s at line %d %@", __func__, __LINE__, [err localizedDescription]);
    }
    
    for (NSManagedObject* obj in objs) {
        //@"lineNumber" string is the attributes 's name
        NSInteger index = [[obj valueForKey:@"lineNumber"] integerValue];
        
        
        NSString* content = [obj valueForKey:@"lineText"];
        UITextField* text = self.textFields[index];
        text.text = content;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)screenTapped:(UIControl *)sender {
    // Dismiss the keyboard
    [self.view endEditing:YES];
}

- (IBAction)saveBtnClicked:(UIButton *)sender {
    for (int i = 0; i < [self.textFields count]; i ++) {
        NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Line"];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(%K==%d)", @"lineNumber", i];
        [request setPredicate:predicate];
        
        // Execute the request
        NSError* err;
        NSArray* objects = [self.context executeFetchRequest:request
                                                       error:&err];
        if (objects == nil) {
            NSLog(@"Error encounted %@", [err localizedDescription]);
        }
        
        NSManagedObject* theLine = nil;
        if ([objects count] > 0) {
            theLine = [objects firstObject];
        }
        else {
            theLine = [NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:self.context];
        }
        
        // Get the textFiel
        UITextField* textField = self.textFields[i];
        
        [theLine setValue:[NSNumber numberWithInt:i] forKey:@"lineNumber"];
        [theLine setValue:textField.text forKey:@"lineText"];
    }
    
    
    
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate saveContext];
}
@end
