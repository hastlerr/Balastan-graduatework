//
//  AppDelegate.m
//  Balastan
//
//  Created by Avaz on 2/19/16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "AppDelegate.h"
#import <Quickblox/Quickblox.h>

const NSUInteger kApplicationID = 36631;
NSString *const kAuthKey        = @"OWZZxY-utAeeqRf";
NSString *const kAuthSecret     = @"ekSvJRwpwGwd9Zy";
NSString *const kAccountKey     = @"GshhCLekRnY7BasExdTz";

@interface AppDelegate ()<AVAudioPlayerDelegate>

@property(strong, nonatomic) AVAudioPlayer* player;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AVAudioSession* audioSession=[AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    
    NSURL* url=[[NSBundle mainBundle] URLForResource:@"fon" withExtension:@".m4a"];
    
    
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player setDelegate:self];
    [self.player play];
    
    [QBSettings setApplicationID:kApplicationID];
    [QBSettings setAuthKey:kAuthKey];
    [QBSettings setAuthSecret:kAuthSecret];
    [QBSettings setAccountKey:kAccountKey];
    
    sleep(3);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
