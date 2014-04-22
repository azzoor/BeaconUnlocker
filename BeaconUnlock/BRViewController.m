//
//  BRViewController.m
//  BeaconUnlock
//
//  Created by Aaron Stephenson on 22/04/2014.
//  Copyright (c) 2014 Bronron Apps. All rights reserved.
//

#import "BRViewController.h"
#import "BRBeaconUnlocker.h"

@interface BRViewController () <BRBeaconUnlockerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *dogButton;
@property (weak, nonatomic) IBOutlet UIButton *catButton;

@end

@implementation BRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [BRBeaconUnlocker sharedInstance].delegate = self;
    [[BRBeaconUnlocker sharedInstance]startLookingForBeaconsIn:@[@{brBEACON_UUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"], brBEACON_ID: @"dogBeacon", brBEACON_DISTANCE: [NSNumber numberWithInt:BRProximityImmediate]}]];
}

- (void)foundBeacon:(NSDictionary *)beacon distanceFromBeacon:(CLProximity)distance
{
    if ([[beacon objectForKey:brBEACON_ID]isEqualToString:@"dogBeacon"]) {
        if (distance == BRProximityImmediate) {
            self.dogButton.enabled = YES;
        }else{
            self.dogButton.enabled = NO;
        }
    }
}

@end
