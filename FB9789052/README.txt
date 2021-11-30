# Broken Renewal of MAS Receipts (Sandbox and Production)

Area: StoreKit
Type: Incorrect/Unexpected Behavior

I started integrating on-device App Store receipt validation into my Mac app, currently not utilizing StoreKit for any kind of in-app purchases. I followed the documentation and employed a check that calls exit(173) if the receipt is invalid. According to the documentation, this should trigger a renewal of the receipt. When I launch the app from Xcode's build folder for the first time, I get correctly presented with the App Store login window. After entering credentials of a sandbox user configured in App Store Connect, the app quits, relaunches, and then the following dialog appears:

"MyApp" is damaged and can't be opened. Delete "MyApp" and download it again from the App Store.

The Console app shows the following information:

storeuid      Fetching missing receipt for sandbox app /Users/[...]/Build/Products/Debug/MyApp.app
storeuid      <StoreKitClient: 0x7fad82e5df60>: Using active account. Sandbox: 1, receipt exists: NO, receipt is stub: NO
commerce      storeuid[1045] starting request app-receipt-create
commerce      <CKStoreRequest: 0x7f8713c0da90> https://p100-sandbox.itunes.apple.com/WebObjects/MZFinance.woa/wa/createAppReceipt
commerce      StoreSession: StatusCode: 200; <private>; Environment: SB-MR; URL: https://p100-sandbox.itunes.apple.com/WebObjects/MZFinance.woa/wa/createAppReceipt
storeuid      <ReceiptRefreshRequest: 0x7fad62c19c10>: No receipt data in response
storeuid      <ReceiptRefreshRequest: 0x7fad62c19c10>: Error fetching receipt for com.example.MyApp - Error Domain=com.apple.commerce.client Code=500 "(null)"
storelegacy   StoreLegacy: Failed to perform in-line receipt renewal for application at path /Users/[...]/Build/Products/Debug/MyApp.app : 'Error Domain=com.apple.commerce.client Code=500 "(null)“‘

There seems to be an issue with retrieving renewed receipts, and it looks like many developers are struggling with this (see related links below).

The mentioned issue doesn't only occur in the sandbox but also for production apps. When removing the _MASReceipt folder from the production app, it's supposed to renew the receipt when launched. Instead, the same dialog informing about the damaged app is shown, and the app has to be re-downloaded entirely from the Mac App Store.

Related Dev Forum posts:
- https://developer.apple.com/forums/thread/694897
- https://developer.apple.com/forums/thread/694922
- https://developer.apple.com/forums/thread/676554
- https://developer.apple.com/forums/thread/676634
- https://developer.apple.com/forums/thread/659149
- https://developer.apple.com/forums/thread/659171
- https://developer.apple.com/forums/thread/659083

Related feedbacks (possibly):
- FB9755646
- FB8620533
- FB8620384
- FB8620903
