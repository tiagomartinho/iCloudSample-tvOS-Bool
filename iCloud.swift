import Foundation

class iCloud {
    
    static let kUbiquityIdentityTokenKey = "tm.UbiquityIdentityToken"
    
    static func registerForiCloudNotificatons() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iCloudAvailabilityChanged:", name: NSUbiquityIdentityDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyValueStoreDidChangeExternally:", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: nil)
    }
    
    static var isAvailable:Bool {
        return (NSFileManager.defaultManager().ubiquityIdentityToken != nil)
    }
    
    static func iCloudAvailabilityChanged(notification: NSNotification?){
        updateState()
    }
    
    static func updateState() {
        //TODO compare with previous state and in case that is un/available copy data from iCloud to local storage and vice versa
        if isAvailable {
            NSUserDefaults.standardUserDefaults().setObject(tokenData, forKey: kUbiquityIdentityTokenKey)
        }
        else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(kUbiquityIdentityTokenKey)
        }
    }
    
    static var tokenData:NSData? {
        if let currentiCloudToken = NSFileManager.defaultManager().ubiquityIdentityToken {
            let newTokenData: NSData = NSKeyedArchiver.archivedDataWithRootObject(currentiCloudToken)
            return newTokenData
        }
        else {
            return nil
        }
    }
    
    static func keyValueStoreDidChangeExternally(notification: NSNotification?){
        guard let changeReason = notification?.userInfo?[NSUbiquitousKeyValueStoreChangeReasonKey]?.integerValue else { return }
        
        switch changeReason {
        case NSUbiquitousKeyValueStoreServerChange:
            break
        case NSUbiquitousKeyValueStoreInitialSyncChange:
            break
        case NSUbiquitousKeyValueStoreQuotaViolationChange:
            break
        case NSUbiquitousKeyValueStoreAccountChange:
            break
        default:
            break
        }
        synchronize()
    }
    
    static func synchronize() {
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
    }
}