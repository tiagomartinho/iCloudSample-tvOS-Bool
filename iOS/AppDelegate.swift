import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        iCloud.updateState()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iCloudAvailabilityChanged:", name: NSUbiquityIdentityDidChangeNotification, object: nil)
        
        return true
    }
    
    func iCloudAvailabilityChanged(notification: NSNotification?){
        iCloud.updateState()
    }
}