# Deprecation of CloudKit user discoverability APIs in iOS 17

- Platform: iOS
- Area: CloudKit
- Type: Suggestion

In iOS 17, all CloudKit APIs for discovering users have been deprecated (including `CKDiscoverAllUserIdentitiesOperation`), leaving no documented way to create social experiences similar to Apple’s first-party apps. We’d like to ask for guidance on how to implement such experiences or replacement APIs that would allow the discoverability of users in a third-party app.

## Response from Apple

CloudKit has deprecated the Look Me Up API in macOS 14.0. This is a necessary change to support CloudKit's standard sharing flows and to protect end user privacy. Due to the nature of the change, there isn't a direct replacement that can be provided from CloudKit. 

Unfortunately, this deprecation may require changes to your application's features that use this API. If your application requires personally identifiable information in this flow, you will need to request that and manage it from users.

The best approach moving forward is to use CloudKit's sharing API to connect users in your application. Links to relevant documents and videos are provided below:

- https://developer.apple.com/documentation/cloudkit/shared_records/sharing_cloudkit_data_with_other_icloud_users
- https://developer.apple.com/documentation/cloudkit/ckshare
- https://developer.apple.com/documentation/cloudkit/ckshare/participant
- https://developer.apple.com/videos/play/tech-talks/10874/
