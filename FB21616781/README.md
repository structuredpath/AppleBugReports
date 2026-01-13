# Non-atomic batch operations fail atomically with encrypted fields in CloudKit

- Platform: iOS
- Area: CloudKit
- Type: Incorrect/Unexpected Behavior
- Build: iOS 18.7.3

## Summary

When using `CKModifyRecordsOperation` or `CKSyncEngine` to save multiple CloudKit records with encrypted fields in a non-atomic batch (with `isAtomic = false`), the CloudKit server incorrectly treats the operation as atomic. If one record in the batch fails with a conflict error such as `.serverRecordChanged`, other unrelated records in the same batch fail with `.batchRequestFailed` and the server message "Atomic failure", even though atomicity was explicitly disabled.

This issue does not occur when using regular, non-encrypted fields. Switching from encrypted to non-encrypted fields causes the batch to behave correctly as non-atomic, with only the conflicting record failing while other records save successfully.

The atomic failure behavior originates from CloudKit's server, not from the client implementation. This has been confirmed through detailed analysis of CloudKit logs and sysdiagnose files.

## Steps to Reproduce

1. Set up two devices syncing to the same CloudKit private database with a custom record zone
2. Create a record with encrypted fields using `CKRecord`'s encrypted field APIs and sync it to both devices
3. On one device, modify and save the record to CloudKit
4. On the other device, modify the same record locally using an older change tag (creating a conflict) and create a new unrelated record
5. Attempt to save both the modified record and the new record together in a non-atomic batch using `CKModifyRecordsOperation` with `isAtomic = false` or `CKSyncEngine`

## Expected Behavior

Since the batch operation is configured as non-atomic:
- The modified record should fail with `.serverRecordChanged` error (due to the conflict)
- The new unrelated record should save successfully to CloudKit
- The operation should complete with partial success

## Actual Behavior

The CloudKit server treats the batch as atomic:
- The modified record fails with `.serverRecordChanged` error
- The new unrelated record fails with `.batchRequestFailed` (error code 22) with server message "Atomic failure"
- Both records fail to save, even though only the modified record has a conflict

CloudKit logs show:
```
<CKError "Server Record Changed" (14/2004)
  server message = "client oplock error updating record"
  …
>

<CKError "Batch Request Failed" (22/2024)
  server message = "Atomic failure"
  …
>
```

## Key Findings

1. Encrypted fields are the trigger: When the same records are configured with regular (non-encrypted) fields instead of encrypted fields, the issue disappears completely and the batch correctly operates in non-atomic mode.
2. Advanced Data Protection: The issue occurs with Advanced Data Protection enabled. It could also be observed in the Simulator with Advanced Data Protection disabled.
3. Server-side issue: The client correctly creates `CKModifyRecordsOperation` with `isAtomic = false`, but the server still returns atomic failure responses. This was confirmed by a former CloudKit engineer.
4. Reproducible with multiple APIs: The issue occurs with both direct `CKDatabase.modifyRecords()` calls and `CKSyncEngine` managed operations.
5. Conflict source matters: The issue is most consistently reproducible when the conflict originates from a different device. Some variations in behavior have been observed when conflicts come from the same device or depending on whether a record has previously encountered `.serverRecordChanged`.

## Supporting Files

Two sysdiagnose files are attached, both captured with the CloudKit logging profile installed:
- `sysdiagnose_2025.12.06_19-24-36+0700_iPhone-OS_iPhone_22H31.tar.gz` - CKSyncEngine reproduction
- `sysdiagnose_2025.12.07_13-57-52+0700_iPhone-OS_iPhone_22H124.tar.gz` - CKDatabase.modifyRecords() reproduction

Both include CloudKit logs showing the server returning "Atomic failure" responses despite `isAtomic = false`.

## Further Resources

- SQLiteData library investigation: https://github.com/pointfreeco/sqlite-data/issues/315
- iOS Folks Slack: https://iosdevelopers.slack.com/archives/C0EDADRCN/p1764587533996549
