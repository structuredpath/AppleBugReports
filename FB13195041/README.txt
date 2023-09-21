# Allow share invitees to add participants, similar to Apple’s first-party apps

- Platform: iOS
- Area: CloudKit
- Type: Suggestion

In CloudKit, only the owner of a share can invite additional participants. This limitation doesn’t align with the behavior seen in Apple’s first-party apps like Reminders and Freeform, where invited participants can also invite others. The owner can even configure this capability in the `UICloudSheetController`. We’d like to request this feature for third-party apps, ideally with low-level API, allowing us to use this feature without the `UICloudSheetController`.
