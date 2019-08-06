//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Mitch Merrell on 8/5/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func cellSwitchValueChanged(cell: SwitchTableViewCell, isOn: Bool)
}

class SwitchTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    private func updateViews() {
        guard let alarmStatus = alarm else { return }
        alarmSwitch.isOn = alarmStatus.enabled
        nameLabel.text = alarmStatus.name
        timeLabel.text = alarmStatus.fireTimeAsString
    }
    
    //MARK: Actions
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.cellSwitchValueChanged(cell: self, isOn: alarmSwitch.isOn)
//        guard let alarm = alarm else { return }
//        alarm.enabled = !alarmSwitch.isOn
        updateViews()
    }
    
}
