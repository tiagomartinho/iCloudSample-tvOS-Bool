import UIKit

class ViewController: UIViewController, iCloudUpdates {
    
    var aBoolInTheCloud:iCloudBool?
    var anotherBoolInTheCloud:iCloudBool?
    var yetAnotherBoolInTheCloud:iCloudBool?

    @IBOutlet weak var boolSegmentedControl: UISegmentedControl!
    @IBOutlet weak var anotherBoolSegmentedControl: UISegmentedControl!
    @IBOutlet weak var yetAnotherBoolSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aBoolInTheCloud = iCloudBool(iCloudKey: "aBoolInTheCloud", observer: self)
        anotherBoolInTheCloud = iCloudBool(iCloudKey: "anotherBoolInTheCloud", observer: self)
        yetAnotherBoolInTheCloud = iCloudBool(iCloudKey: "yetAnotherBoolInTheCloud", observer: self)
        updateUI()
    }
    
    func updateUI(){
        boolSegmentedControl.selectedSegmentIndex = (aBoolInTheCloud?.value ?? false) ? 1 : 0
        anotherBoolSegmentedControl.selectedSegmentIndex = (anotherBoolInTheCloud?.value ?? false) ? 1 : 0
        yetAnotherBoolSegmentedControl.selectedSegmentIndex = (yetAnotherBoolInTheCloud?.value ?? false) ? 1 : 0
    }
    
    @IBAction func toogleState(sender: UISegmentedControl) {
        aBoolInTheCloud?.value = (boolSegmentedControl.selectedSegmentIndex == 1)
        anotherBoolInTheCloud?.value = (anotherBoolSegmentedControl.selectedSegmentIndex == 1)
        yetAnotherBoolInTheCloud?.value = (yetAnotherBoolSegmentedControl.selectedSegmentIndex == 1)
    }
    
    func iCloudValuesDidChange(){
        updateUI()
    }
}