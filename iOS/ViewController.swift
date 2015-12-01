import UIKit

class ViewController: UIViewController {
  
    var aBoolInTheCloud:Bool = true
    
    @IBOutlet weak var boolSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if iCloud.isAvailable {
            updateState()
        }
        updateUI()
    }
    
    func updateState(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {() -> Void in
            if let myContainer = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil){
                // Your app can write to the iCloud container
                print(myContainer)
                
                self.aBoolInTheCloud = NSUbiquitousKeyValueStore.defaultStore().boolForKey("aBoolInTheCloud")
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    // On the main thread, update UI and state as appropriate
                    self.updateUI()
                })
            }
        })
    }
    
    func updateUI(){
        boolSegmentedControl.selectedSegmentIndex = aBoolInTheCloud ? 1 : 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
}