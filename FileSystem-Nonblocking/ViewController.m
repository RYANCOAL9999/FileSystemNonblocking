//
//  ViewController.m
//  FileSystem-Nonblocking
//
//  Created by Steven Poon on 16/12/2015.
//  Copyright © 2015 Steven Poon. All rights reserved.
//

#import "ViewController.h"
#import "FileSystem_Nonblocking-Swift.h"
#import "FileSystem_Nonblocking_steamevents.h"



@interface ViewController ()

@property(strong,nonatomic)MyClass *abcclass;

@end

@implementation ViewController

@class MyClass;
@class MySwiftClass;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MySwiftClass *swiftObject = [[MySwiftClass alloc] init];
    [swiftObject sayHello];
    
    //int result = [swiftObject addX:5 andY:5];
    
    //NSLog(@"5 + 5 is %d", result);
    
    //NSDictionary *dictionary = [swiftObject dictionaryWithKeys:@[@"key1",@"key2",@"key3"]
                                                     //andValues:@[@"val1",@"val2",@"val3"]];
    
    //NSLog(@"%@",dictionary);
    
    _abcclass = [[MyClass alloc]init];

    UITextField *ui = [UITextField alloc];
    ui.text = @"\u00a0";
    FileSystem_Nonblocking_steamevents *events = [[FileSystem_Nonblocking_steamevents alloc] init];
    [events testsetUpStreamForFile];
    
    //[events stream:events.newevents handleEvent:1];
    [events Getdata];
    NSLog(@"this is new eventCode %lu",(unsigned long)events.newhandleevents);
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

