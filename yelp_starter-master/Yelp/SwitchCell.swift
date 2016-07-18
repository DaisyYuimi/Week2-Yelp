//
//  SwitchCell.swift
//  Yelp
//
//  Created by sophie on 7/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
   optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}


class SwitchCell: UITableViewCell {
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func onSwitchAction(sender: UISwitch) {
        print(onSwitch.on)
        delegate?.switchCell!(self, didChangeValue: onSwitch.on)
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
