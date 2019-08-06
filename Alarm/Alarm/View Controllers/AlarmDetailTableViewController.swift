//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Mitch Merrell on 8/5/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: Outlets
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmToggleButton: UIButton!
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
        
    }
    
    var alarmIsOn: Bool {
        guard let alarmStatus = alarm else { return true }
        return alarmStatus.enabled
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    private func updateViews() {
        guard let alarmToUpdate = alarm else { return }
        alarmDatePicker.date = alarmToUpdate.fireDate
        alarmNameTextField.text = alarmToUpdate.name
        if alarmToUpdate.enabled {
            alarmToggleButton.backgroundColor = .green
            alarmToggleButton.setTitle("On", for: .normal)
            tableView.reloadData()
        } else {
            alarmToggleButton.backgroundColor = .red
            alarmToggleButton.setTitle("Off", for: .normal)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: Actions

    @IBAction func enableButtonTapped(_ sender: Any) {
        // todo
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // todo
    }
}
