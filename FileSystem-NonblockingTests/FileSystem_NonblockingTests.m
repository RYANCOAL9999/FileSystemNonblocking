//
//  FileSystem_NonblockingTests.m
//  FileSystem-NonblockingTests
//
//  Created by Steven Poon on 16/12/2015.
//  Copyright © 2015 Steven Poon. All rights reserved.
//

#import "ViewController.h"
#import "FileSystem_Nonblocking_steamevents.h"
#import <XCTest/XCTest.h>



@interface FileSystem_NonblockingTests : XCTestCase 

@end


@implementation FileSystem_NonblockingTests

@class MyClass;



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReadFile {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *rootpath = [paths objectAtIndex:0];
    NSLog(@"this is root path %@",rootpath);
    NSError *error = nil;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootpath error:&error];
    NSLog(@"this is file content%@",directoryContents);
    NSString *changepath = [rootpath stringByDeletingLastPathComponent];
    for(int i = 0; i< 10; i++){
        changepath = [changepath stringByDeletingLastPathComponent];
    }
    changepath = [changepath stringByAppendingString:@"/Downloads/FileSystem-Nonblocking/TextFile.txt"];
    
    NSLog(@"this is change path %@",changepath);
    
    /*FILE *fileHandle = fopen([changepath UTF8String], "r");
     
     char space[1024];
     
     while (fgets(space, 1024, fileHandle)!= NULL)
     {
     NSLog(@"space = %s", space);
     }
     fclose(fileHandle);*/
    
    NSInputStream *ins = [NSInputStream inputStreamWithFileAtPath:changepath];
    [ins setDelegate:NULL];
    [ins scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [ins open];
    uint8_t buffer[7*1024*1024];
    int times=0;
    
    for(int i = 0; i< 110; i++){
        NSUInteger len  = [ins read:buffer maxLength:7*1024*1024];
        NSLog(@"this is new string %u %lu ",times,(unsigned long)len);
        times++;
    }
    
//    NSUInteger len  = [ins read:buffer maxLength:7*1024*1024];
//    NSLog(@"this is new string %lu ",(unsigned long)len);
//    NSData *data = [NSData dataWithBytes:(void *)buffer length:len];
    
    //NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"this is new string %@",data);
    [ins close];
    
    
}



- (void)testWriteFile {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *rootpath = [paths objectAtIndex:0];
    NSLog(@"this is root path %@",rootpath);
    NSError *error = nil;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootpath error:&error];
    NSLog(@"this is file content%@",directoryContents);
    NSString *changepath = [rootpath stringByDeletingLastPathComponent];
    for(int i = 0; i< 10; i++){
        changepath = [changepath stringByDeletingLastPathComponent];
    }
    changepath = [changepath stringByAppendingString:@"/Downloads/FileSystem-Nonblocking/TextFile.txt"];
    
    NSLog(@"this is change path %@",changepath);
    
    //NSString *newstring = @"fucking help!!!!!!";
    
    //NSData *data = [newstring dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    /*NSOutputStream *writeStream = [[NSOutputStream alloc]initToFileAtPath:changepath append:YES];
    //[writeStream setDelegate:self];
    
    [writeStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [writeStream open];
    
    [writeStream write:[data bytes] maxLength:[data length]];
    
    [writeStream close];
    
    NSInputStream *ins = [NSInputStream inputStreamWithFileAtPath:changepath];
    [ins scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [ins open];
    uint8_t buffer[1024];
    NSUInteger len  = [ins read:buffer maxLength:1024];
    NSData *newdata = [NSData dataWithBytes:(void *)buffer length:len];
    
    NSString *string = [[NSString alloc]initWithData:newdata encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",string);
    */
    
    

}

-(void)teststeamsevents{
    
    FileSystem_Nonblocking_steamevents *events = [[FileSystem_Nonblocking_steamevents alloc]init];
    [self measureBlock:^{
        [events testsetUpStreamForFile];
        //[events stream:events.newevents handleEvent:*(events.newhandleevents)];
        [events Getdata];
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
