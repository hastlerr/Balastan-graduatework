//
//  InfoViewController.m
//  Balastan
//
//  Created by Avaz on 04.03.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)balastanButtonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.balastan.com"]];
}
- (IBAction)facebookButtonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/balastankg/"]];
}
- (IBAction)youtubeButtonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UCATdGT_5OkUWIkvrK6vbBZw"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
