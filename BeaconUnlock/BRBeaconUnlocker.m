//
//  BRContentUnlocker.m
//  BeaconUnlock
//
//  Created by Aaron Stephenson on 22/04/2014.
//  Copyright (c) 2014 Bronron Apps. All rights reserved.
//

#import "BRBeaconUnlocker.h"

@interface BRBeaconUnlocker () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *rangedRegions;
@property (nonatomic, strong) NSArray *beaconsArray;

@end

@implementation BRBeaconUnlocker

- (void)startLookingForBeaconsIn:(NSArray *)array
{
    self.beaconsArray = array;
    [self setupToRangeForBeacons];
}

- (void)stopLookingForBeacons
{
    [self stopRangingForBeacons];
}

#pragma mark - Beacon Setup
- (void)setupToRangeForBeacons
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.rangedRegions = [NSMutableArray array];
    
    for (NSDictionary *dictionary in self.beaconsArray) {
        NSUUID *uuid = (NSUUID *)[dictionary objectForKey:brBEACON_UUID];
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:[uuid UUIDString]];
        [self.rangedRegions addObject:region];
    }
    
    [self.rangedRegions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CLBeaconRegion *region = obj;
        [self.locationManager startRangingBeaconsInRegion:region];
    }];
}

- (void)stopRangingForBeacons
{
    for (CLBeaconRegion *region in self.rangedRegions) {
        [self.locationManager stopRangingBeaconsInRegion:region];
    }
    
    self.locationManager.delegate = nil;
    [self.rangedRegions removeAllObjects];
}

#pragma mark - CoreBluetooth

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] > 0) {
        //Todo: Allow for multiple Beacons
        CLBeacon *nearestBeacon = [beacons firstObject];
        for (NSDictionary *dictionary in self.beaconsArray) {
            if ([[nearestBeacon.proximityUUID UUIDString] isEqualToString:[[dictionary objectForKey:brBEACON_UUID]UUIDString]]) {
                id<BRBeaconUnlockerDelegate> strongDelegate = self.delegate;
                if ([strongDelegate respondsToSelector:@selector(foundBeacon:distanceFromBeacon:)]) {
                    [strongDelegate foundBeacon:dictionary distanceFromBeacon:nearestBeacon.proximity];
                }
            }
        }
    }
}


#pragma mark - Class Methods

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

@end
