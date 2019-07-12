# MMEBugRepro
Xcode project to reproduce perceived bug in Mapbox Mobile Events framework

### MMELocationManagerRegionIdentifier.fence.center

Hi,

My instance of `CLLocationManager` is having its delegate method `didStartMonitoringFor region: CLRegion` called with a region identifier of `MMELocationManagerRegionIdentifier.fence.center` - to me, that means it's coming from a `CLLocationManager` instance existing on `MMELocationManager` within `MGLMapView`.

My issue is the sheer volume of calls that are made. It happens with a period of from 1 second to 10 seconds, and in some cases it can go out of control and is called up to 10 times per second, on one device.

It's critical for me to be able to monitor region identifiers of my app in the field, which is how I noticed since my logs are almost entirely this same call. I could filter it out, but it seems like a bug to me and I wanted to share because I really love the Mapbox product and look forward to integrating it in this project for keeps.

Repro project on GitHub is here. This is my first try pushing an Xcode project repository - If you have any feedback please fire away.

**Notes** 

1. The issue disappears on simulator, so to reproduce you'll need to run it on a device. I've tried on an iPhone 6 and an iPhone X.
2. The period of these calls fluctuates, but it's always present - an extra call or two wouldn't be alarming enough to open this issue, but there is no need to ask `CoreLocation` to monitor this region at **10Hz**.



### Steps to Reproduce
1. Build and run project on a device
2. Observe console output

### Expected Behaviour
The region `MMELocationManagerRegionIdentifier.fence.center` should only be registered with `CLLocationManager`'s `monitoredRegions` once.

### Actual Behaviour	
The delegate method is called as often as 10 times per second.

### Configuration

- Mapbox iOS SDK 5.1
- iOS 12.1.4
- iPhone 6, iPhone X
- Xcode 10.2.1




