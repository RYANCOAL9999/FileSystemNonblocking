//
//  FileSystem_Nonblocking_steamevents.m
//  FileSystem-Nonblocking
//
//  Created by Steven Poon on 15/1/2016.
//  Copyright © 2016 Steven Poon. All rights reserved.
//

#import "FileSystem_Nonblocking_steamevents.h"

@implementation FileSystem_Nonblocking_steamevents

- (void)testsetUpStreamForFile{
    
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
    
    _ins = [NSInputStream inputStreamWithFileAtPath:changepath];
    [_ins setDelegate:self];
    [_ins scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_ins open];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.00246609]];
    
}


- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    _newhandleevents = eventCode;
    
    NSLog(@"this is eventCode %lu",(unsigned long)eventCode);
    switch (eventCode) {
        case NSStreamEventEndEncountered:
        {
            NSLog(@"Stream closed");
            [stream close];
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            //[stream release]; //error for ARC
            stream = nil;
            break;
        }
            
        case NSStreamEventErrorOccurred:
        {
            NSLog(@"Can not connect to the host!!");
            NSError *theError = [stream streamError];
            /*NSAlert *theAlert = [[NSAlert alloc] init];
             [theAlert setMessageText:@"Error reading stream!"];
             [theAlert setInformativeText:[NSString stringWithFormat:@"Error %i: %@",
             [theError code], [theError localizedDescription]]];
             [theAlert addButtonWithTitle:@"OK"];
             [theAlert beginSheetModalForWindow:[NSApp mainWindow]
             modalDelegate:self
             didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
             contextInfo:nil];*/
            NSLog(@"this is error%@",theError);
            [stream close];
            //[stream release]; //error for ARC
            break;
        }
            
        case NSStreamEventNone:
        {
            NSLog(@"None Event of NSStream!!");
            break;
        }
            
        case NSStreamEventOpenCompleted:
        {
            NSLog(@"Stream opened!!");
            break;
        }
            
        case NSStreamEventHasBytesAvailable:
        {
            NSLog(@"Stream Has Bytes Available!!");
            
            NSInteger bytesRead;
            uint8_t   buffer[1024000];
            NSInteger total = 0;
            int i = 0;
            do {
                NSInputStream * is = (NSInputStream *)stream;
                bytesRead = [(NSInputStream *)stream read:buffer maxLength:sizeof(buffer)];
                NSLog(@"this is bytesRead %ld %d %d",(long)bytesRead,i,is.hasBytesAvailable);
                i += 1;
                total += bytesRead;
            } while (bytesRead > 0);
            
            NSLog(@"this is new int %d",i);
            NSLog(@"this is total %ld",(long)total);
            
            break;
        }
            
        case NSStreamEventHasSpaceAvailable:
        {
            NSLog(@"Stream has space available!!");
            /*if (stream == oStream) {  //error for has not oStream
             NSString * str = [NSString stringWithFormat:
             @"GET / HTTP/1.0\r\n\r\n"];
             const uint8_t * rawstring =
             (const uint8_t *)[str UTF8String];
             [oStream write:rawstring maxLength:strlen(rawstring)];
             [oStream close];
             }*/
            break;
        }
            
            
    }
}

-(void)Getdata{
    
    uint8_t buffer[1024];  //iphone real buf may be 2736
    NSUInteger len = [_ins read:buffer maxLength:sizeof(buffer)];
    NSLog(@"this is new string %lu ",(unsigned long)len);
    
    NSData *data = [NSData dataWithBytes:(void *)buffer length:len];
    NSLog(@"this is new data %@",data);
    CFRunLoopStop(CFRunLoopGetCurrent());
    [_ins close];
    
}

@end
