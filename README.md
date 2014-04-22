# BRBeaconUnlocker

##About

BRBeaconUnlock is an easy to use method to unlock content in iOS apps using iBeacons. It was built for a project I have been working on and I thought I would share it with other developers. The whole idea is to have iBeacons around a room and as a user approaches these beacons different animations and content would be made available. As the user moves away from the beacon the content then locks and becomes unavailable.

## Installation

Copy the BRBeaconUnlocker.h and BRBeaconUnlocker.m file into your project.

## Usage

- Import the "BRBeaconUnlocker.h" into your view controller.

- Declare that you be a delegate of BRBeaconUnlocker in the @Interface. 
	<BRBeaconUnlockerDelegate>

- In your viewDidLoad set yourself as the delegate and start looking for beacons.
	[BRBeaconUnlocker sharedInstance].delegate = self;
	[[BRBeaconUnlocker sharedInstance]startLookingForBeaconsIn:@[@{brBEACON_UUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"], brBEACON_ID: @"dogBeacon", brBEACON_DISTANCE: [NSNumber numberWithInt:BRProximityImmediate]}]];

Add the delegate method to begin receiving beacons found.
	- (void)foundBeacon:(NSDictionary *)beacon distanceFromBeacon:(CLProximity)distance

## Example Project

Run the example project to test the unlock methods.

## Requirements

- CoreLocation.framework

## Further Development

- Handling detecting of multiple beacons.
- Fixing the interference and dropout of beacons.

## Author

Aaron Stephenson, [@iosaaron](https://twitter.com/iosaaron)

## License

BRBeaconUnlock is available under the MIT license. See the LICENSE file for more info.
