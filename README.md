## Places

Places is a SwiftUI-based iOS application that demonstrates deep linking functionality with a modified version of the Wikipedia. It allows users to explore various locations and open them directly in the Wikipedia app's 'Places' tab.

> [!TIP] 
> It is meant to be used with a [modified version](https://github.com/vdseam/wikipedia-ios) of the Wikipedia iOS app. Please clone and build **both projects** on any convenient device or simulator before testing.

> [!WARNING]
> **Bug found:** if the user does not give permission to get location, the location coordinates are not applied because `LocationManagerDelegate` methods are not triggered. It can be fixed by executing the `zoomAndPanMapView(toLocation:)` method in `viewWillAppear(_:)`. Changes are not made due to deadline.

## Demo

https://github.com/user-attachments/assets/9efd46ff-327f-4d09-b217-32c93156c57c
