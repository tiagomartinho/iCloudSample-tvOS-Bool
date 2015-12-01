import UIKit

class ViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {() -> Void in
            if let myContainer = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil){
                // Your app can write to the iCloud container
                print(myContainer)
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    // On the main thread, update UI and state as appropriate
                })
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let alert = UIAlertController()
        alert.message = "is iCloudAvailable \(iCloud.isAvailable)"
        self.presentViewController(alert, animated: true, completion: nil)
    }
}