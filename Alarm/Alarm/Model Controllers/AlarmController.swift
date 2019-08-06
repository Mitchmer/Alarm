//
//  AlarmController.swift
//  Alarm
//
//  Created by Mitch Merrell on 8/5/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

class AlarmController {
    
    //MARK: Properties
    
    var alarms = [Alarm]()
    
    //MARK: SoT & Shared Instance
    
    static let sharedInstance = AlarmController()

    init() {
        let mockAlarms: [Alarm] = {
           return [
                Alarm(fireDate: Date(), name: "Class", enabled: true),
                Alarm(fireDate: Date(), name: "Dinner", enabled: false),
                Alarm(fireDate: Date(), name: "Bowling", enabled: false),
                Alarm(fireDate: Date(), name: "TV Show", enabled: true)
            ]
        }()
        alarms = mockAlarms
    }
    
    func toggleEnabled(for alarm: Alarm, isOn: Bool) {
        alarm.enabled = !isOn
    }
    
    // MARK: CRUD
    
    //create
    func createAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        
        // save
    }
    
    //update
    func updateAlarm(fireDate: Date, name: String, enabled: Bool, alarm: Alarm) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        
        //save
    }
    
    //delete
    func deleteAlarm(alarm: Alarm) {
        guard let alarmIndex = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: alarmIndex)
        
        // save
    }
    
}
