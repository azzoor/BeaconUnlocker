//
//  BRContentUnlocker.h
//  BeaconUnlock
//
//  Created by Aaron Stephenson on 22/04/2014.
//  Copyright (c) 2014 Bronron Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol BRBeaconUnlockerDelegate;

@interface BRBeaconUnlocker : NSObject

- (void)startLookingForBeaconsIn:(NSArray *)array;
- (void)stopLookingForBeacons;

@property (nonatomic, weak) id<BRBeaconUnlockerDelegate> delegate;

#pragma mark - Class Methods
+ (instancetype)sharedInstance;

@end

@protocol BRBeaconUnlockerDelegate <NSObject>

- (void)foundBeacon:(NSDictionary *)beacon distanceFromBeacon:(CLProximity)distance;

@end