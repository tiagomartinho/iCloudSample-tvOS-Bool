import UIKit

class ViewController: UIViewController, iCloudUpdates {
    
    var aBoolInTheCloud:iCloudBool?

    @IBOutlet weak var boolSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aBoolInTheCloud = iCloudBool(iCloudKey: "aBoolInTheCloud", observer: self)
        updateUI()
    }
    
    func updateUI(){
        boolSegmentedControl.selectedSegmentIndex = (aBoolInTheCloud?.value ?? false) ? 1 : 0
    }
    
    @IBAction func toogleState(sender: UISegmentedControl) {
        aBoolInTheCloud?.value = (boolSegmentedControl.selectedSegmentIndex == 1)
    }
    
    func iCloudValuesDidChange(){
        updateUI()
    }
}