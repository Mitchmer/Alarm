//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Mitch Merrell on 8/5/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AlarmController.sharedInstance.loadFromPersistentStore()
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.sharedInstance.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        let alarmToDisplay = AlarmController.sharedInstance.alarms[indexPath.row]
        
        cell.alarm = alarmToDisplay
        cell.delegate = self
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 99
//    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alarmToDelete = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.deleteAlarm(alarm: alarmToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let index = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? AlarmDetailTableViewController else { return }
                let alarmToSend = AlarmController.sharedInstance.alarms[index.row]
                destinationVC.alarm = alarmToSend
            }
        }
    }

}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    
    func cellSwitchValueChanged(cell: SwitchTableViewCell, isOn: Bool) {
        guard let alarm = cell.alarm, let indexPath = tableView.indexPath(for: cell) else { return }
        AlarmController.sharedInstance.toggleEnabled(for: alarm, isOn: alarm.enabled)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
