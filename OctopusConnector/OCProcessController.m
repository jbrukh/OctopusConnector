//
//  OCProcessController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/26/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCProcessController.h"

@implementation OCProcessController

- (id) init {
    self = [super init];
    if (self) {
        delegate = (OCAppDelegate *)[[NSApplication sharedApplication] delegate];
    }
    return self;
}
- (void)startServer
{
    NSLog(@"Starting Octopus Server.");
    
    // check if the task is running
    if (task != NULL && [task isRunning]) {
        NSLog(@"Octopus Server is already running.");
        return;
    }
    
    //create the task
    task = [[NSTask alloc] init];
    NSString* resourcePath = [[NSBundle mainBundle] pathForResource:OCServerBinary ofType:@""];
    
    [task setLaunchPath:resourcePath];
    NSArray *args = [self getArgs];
    [task setArguments:args];
    
    pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task setStandardError:pipe];
    
    [delegate setStatusItemUp];
    
    // set termination handler
    id weakDelegate = delegate;
    id weakSelf = self;
    [task setTerminationHandler:^(NSTask *localTask){
        // TODO: send notification here with exit code
        [weakDelegate setStatusItemDown];
        int rc = [localTask terminationStatus];
        printf("EXIT CODE %d", rc);
        [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
    }];
    handle = [pipe fileHandleForReading];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOutputFromProcess:) name: NSFileHandleReadCompletionNotification object:handle];
    [task launch];
    [handle readInBackgroundAndNotify];
}

-(NSArray *)getArgs {
    NSMutableArray *result = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // these have defaults
    NSString *device = [defaults stringForKey:OCKeyDevice];
    NSString *repo = [defaults stringForKey:OCKeyRepo];
    
    if ([device isEqualToString:OCDeviceNameDemoDevice]) {
        [result addObject:@"--mockDevice"];
        NSString* obfFile =[[NSBundle mainBundle] pathForResource:OCDemoDataFile ofType:@""];
        [result addObject:@"--mockFile"];
        [result addObject:obfFile];
        [result addObject:@"--mockChannels"];
        [result addObject:@"8"];
    }
    else if ([device isEqualToString:OCDeviceNameAvatar]) {
        [result addObject:@"--device"];
        [result addObject:device];
        [result addObject:@"--port"];
        [result addObject:[defaults valueForKey:OCKeyPortAvatar]];
    }
    else if ([device isEqualToString:OCDeviceNameThinkgear]) {
        [result addObject:@"--device"];
        [result addObject:device];
        [result addObject:@"--port"];
        [result addObject:[defaults valueForKey:OCKeyPortThinkgear]];
    }

    [result addObject:@"--repo"];
    [result addObject:repo];
    NSLog(@"QUERY: %@", result);
    return result;
}

-(void)stopServer
{
    NSLog(@"Stopping Octopus Server.");
    if (task != NULL && [task isRunning]) {
        [task terminate];
        [task waitUntilExit];
        [delegate setStatusItemDown];
    }
}

-(void)handleOutputFromProcess:(NSNotification *)notification
{
    if (task.isRunning) {
        [handle readInBackgroundAndNotify];
        NSData *data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];
        NSString *str;
        str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        // notify observers
        [[NSNotificationCenter defaultCenter] postNotificationName:OCConsoleOutputNotification object:str];
    }
}

@end
