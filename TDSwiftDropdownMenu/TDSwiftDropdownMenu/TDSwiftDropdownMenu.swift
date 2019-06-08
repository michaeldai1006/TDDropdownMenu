import Foundation
import UIKit

protocol TDSwiftDropdownMenuDelegate: class {
    func dropdownMenuItemDidSelected(itemTitle: String)
}

class TDSwiftDropdownMenu: UIView {
    @IBOutlet weak var dropBtn: UIButton!
    @IBAction func dropBtnClicked(_ sender: UIButton) {
        if menuExpanded { dismissOptionList() }
        else { presentOptionList() }
    }
    
    // Appearance
    var cornerRadius: CGFloat = 6.0
    var listBtnHeight: CGFloat = 40.0
    var btnListSpacing: CGFloat = 5.0
    
    // Data
    var dropDownItemList: [String] = [] { didSet { initAppearance() } }
    var optionBtnList: [UIButton] = []
    var menuExpanded = false
    weak var delegate: TDSwiftDropdownMenuDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    private func initAppearance() {
        if let firstItemTitle = dropDownItemList.first {
            self.dropBtn.setTitle(firstItemTitle, for: .normal)
        } else {
            self.dropBtn.setTitle("", for: .normal)
        }
    }
    
    private func setupAppearance() {
        // View
        self.clipsToBounds = true
        self.layer.cornerRadius = 6.0
    }
    
    private func presentOptionList() {
        menuExpanded = true
        
        for dropDownItemTitle in dropDownItemList {
            // Option btn instance
            let optionBtn = UIButton(frame: CGRect(x: self.frame.minX, y: optionBtnList.last?.frame.maxY ?? self.frame.maxY + btnListSpacing, width: self.frame.width, height: listBtnHeight))
            
            // Option btn appearance
            optionBtn.setTitle(dropDownItemTitle, for: .normal)
            optionBtn.setTitleColor(dropBtn.titleLabel?.textColor, for: .normal)
            optionBtn.backgroundColor = self.backgroundColor
            optionBtn.addTarget(self, action: #selector(self.optionBtnClicked(optionBtn:)), for: .touchUpInside)
            
            // Append
            self.superview?.addSubview(optionBtn)
            optionBtnList.append(optionBtn)
        }
    }
    
    private func dismissOptionList() {
        menuExpanded = false
        
        for optionBtn in optionBtnList {
            optionBtn.removeFromSuperview()
        }
        
        optionBtnList.removeAll()
    }
    
    @objc func optionBtnClicked(optionBtn: UIButton) {
        dismissOptionList()
        let titleLabelText = optionBtn.titleLabel?.text ?? ""
        delegate?.dropdownMenuItemDidSelected(itemTitle: titleLabelText)
        dropDownItemList.insert(dropDownItemList.remove(at: dropDownItemList.firstIndex(of: titleLabelText)!), at: 0)
        initAppearance()
    }
    
    class func instanceFromNib() -> TDSwiftDropdownMenu {
        return UINib(nibName: String(describing: TDSwiftDropdownMenu.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TDSwiftDropdownMenu
    }
}
