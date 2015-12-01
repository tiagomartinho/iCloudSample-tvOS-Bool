import Foundation

class iCloud {
    
    static let UbiquityIdentityTokenKey = "tm.UbiquityIdentityToken"
    
    static func updateState() {
        if isAvailable {
            NSUserDefaults.standardUserDefaults().setObject(tokenData, forKey: UbiquityIdentityTokenKey)
        }
        else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(UbiquityIdentityTokenKey)
        }
    }
    
    static var isAvailable:Bool {
        return (NSFileManager.defaultManager().ubiquityIdentityToken != nil)
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
}