import Foundation

struct iCloudBool {
    let iCloudKey:String

    var value:Bool {
        set {
            NSUbiquitousKeyValueStore.defaultStore().setBool(newValue, forKey: iCloudKey)
            NSUbiquitousKeyValueStore.defaultStore().synchronize()
        }
        get {
            NSUbiquitousKeyValueStore.defaultStore().synchronize()
            return NSUbiquitousKeyValueStore.defaultStore().boolForKey(iCloudKey)
        }
    }
    
    init(iCloudKey:String, observer:iCloudUpdates){
        self.iCloudKey = iCloudKey
        NSNotificationCenter.defaultCenter().addObserver(observer as! AnyObject, selector: "iCloudValuesDidChange", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: nil)
    }
}