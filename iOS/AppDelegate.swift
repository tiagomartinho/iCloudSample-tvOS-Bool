import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        iCloudUpdateState()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iCloudAvailabilityChanged:", name: NSUbiquityIdentityDidChangeNotification, object: nil)
        
        return true
    }
    
    func iCloudAvailabilityChanged(notification: NSNotification?){
        iCloudUpdateState()
    }
    
    func iCloudUpdateState() {
        if iCloudAvailable {
            NSUserDefaults.standardUserDefaults().setObject(tokenData, forKey: "com.apple.MyAppName.UbiquityIdentityToken")
        }
        else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("com.apple.MyAppName.UbiquityIdentityToken")
        }
    }
    
    var iCloudAvailable:Bool {
        return (NSFileManager.defaultManager().ubiquityIdentityToken != nil)
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
}