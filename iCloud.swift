import Foundation

class iCloud {
    
    let kUbiquityIdentityTokenKey = "tm.UbiquityIdentityToken"
    
    func registerForiCloudNotificatons() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iCloudAvailabilityChanged:", name: NSUbiquityIdentityDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyValueStoreDidChangeExternally:", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: nil)
    }
    
    var isAvailable:Bool {
        return (NSFileManager.defaultManager().ubiquityIdentityToken != nil)
    }
    
    func iCloudAvailabilityChanged(notification: NSNotification?){
        updateState()
    }
    
    func updateState() {
        //TODO compare with previous state and in case that is un/available copy data from iCloud to local storage and vice versa
        if isAvailable {
            NSUserDefaults.standardUserDefaults().setObject(tokenData, forKey: kUbiquityIdentityTokenKey)
        }
        else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(kUbiquityIdentityTokenKey)
        }
    }
    
    var tokenData:NSData? {
        if let currentiCloudToken = NSFileManager.defaultManager().ubiquityIdentityToken {
            let newTokenData: NSData = NSKeyedArchiver.archivedDataWithRootObject(currentiCloudToken)
            return newTokenData
        }
        else {
            return nil
        }
    }
    
    func keyValueStoreDidChangeExternally(notification: NSNotification?){
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
    
    func synchronize() {
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
    }
}