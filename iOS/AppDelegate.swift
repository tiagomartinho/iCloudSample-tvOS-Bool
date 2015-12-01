import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        iCloud.updateState()
        
        NSNotificationCenter.defaultCenter().addObserver(iCloud.self, selector: "iCloudAvailabilityChanged:", name: NSUbiquityIdentityDidChangeNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(iCloud.self, selector: "keyValueStoreDidChangeExternally:", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: nil)

        return true
    }
}