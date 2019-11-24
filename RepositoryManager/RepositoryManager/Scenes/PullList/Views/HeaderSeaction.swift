//
//  HeaderSeaction.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class HeaderSeaction: UIView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension NSMutableAttributedString {
    @discardableResult func changeColor(_ text: String, color: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
