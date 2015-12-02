import UIKit

class ViewController: UIViewController {
  
    let iCloudKey = "aBoolInTheCloud"
    var aBoolInTheCloud:Bool {
        set {
            NSUbiquitousKeyValueStore.defaultStore().setBool(newValue, forKey: iCloudKey)
            updateUI()
        }
        get {
            return NSUbiquitousKeyValueStore.defaultStore().boolForKey(iCloudKey)
        }
    }
    
    @IBOutlet weak var boolSegmentedControl: UISegmentedControl! {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func toogleState(sender: UISegmentedControl) {
        aBoolInTheCloud = (boolSegmentedControl.selectedSegmentIndex == 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        boolSegmentedControl.selectedSegmentIndex = aBoolInTheCloud ? 1 : 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
}