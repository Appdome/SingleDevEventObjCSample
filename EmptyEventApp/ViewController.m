//
//  ViewController.m
//  EmptyEventApp
//
//  Copyright © 2016 appdome. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()
@property NSString *event_name;
@property NSString *event_data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"EmptyDevEventApp in viewDidLoad - start");
    NSString *event_name = @"JailbrokenDevice";
    [[NSNotificationCenter defaultCenter] addObserverForName: event_name object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.event_name = event_name;
        NSLog(@"EmptyDevEventApp in NSNotificationCenter block");
        NSDictionary *dict = [note userInfo];
        NSMutableString *event_data = [[NSMutableString alloc]init];

        for (NSString* key in dict) {
            id value = dict[key];
            [event_data appendString:[NSString stringWithFormat:@"%@: %@\n", key, value]];
        }

        NSLog(@"EmptyDevEventApp got event %@ with data: %@", event_name, event_data);
        self.event_data = event_data;
    }];
    NSLog(@"EmptyDevEventApp in viewDidLoad - end");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"EmptyDevEventApp in viewDidAppear - start");
    if (self.event_name) {
        NSLog(@"EmptyDevEventApp showing event popup");
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:self.event_name
                                   message:self.event_data
                                   preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSLog(@"EmptyDevEventApp - not showing event popup");
    }
    NSLog(@"EmptyDevEventApp in viewDidAppear - end");
}

@end
