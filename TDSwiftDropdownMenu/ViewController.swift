import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupMenu()
    }
    
    private func setupMenu() {
        // Menu instance
        let menu = TDSwiftDropdownMenu.instanceFromNib()
        
        // Config menu
        menu.dropDownItemList = ["Swift", "Objective-C", "JavaScript", "Python", "Java", "C#"]
        menu.center = self.view.center
        
        // Append
        self.view.addSubview(menu)
    }
}

