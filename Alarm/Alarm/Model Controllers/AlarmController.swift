//
//  AlarmController.swift
//  Alarm
//
//  Created by Mitch Merrell on 8/5/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "\(alarm.name)"
        content.body = "It's time!"
        content.sound = UNNotificationSound.default
        
        var components = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        components.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error)  in
            if let error = error {
                print("NOTIFICATION FAILED")
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}

class AlarmController: AlarmScheduler {
    
    //MARK: Properties
    
    var alarms = [Alarm]()
    
    //MARK: SoT & Shared Instance
    
    static let sharedInstance = AlarmController()

//    init() {
//        let mockAlarms: [Alarm] = {
//           return [
//                Alarm(fireDate: Date(), name: "Class", enabled: true),
//                Alarm(fireDate: Date(), name: "Dinner", enabled: false),
//                Alarm(fireDate: Date(), name: "Bowling", enabled: false),
//                Alarm(fireDate: Date(), name: "TV Show", enabled: true)
//            ]
//        }()
//        alarms = mockAlarms
//    }
    
    func toggleEnabled(for alarm: Alarm, isOn: Bool) {
        alarm.enabled = !isOn
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        
        saveToPersistentStore()
        
    }
    
    // MARK: CRUD
    
    //create
    func createAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        scheduleUserNotifications(for: newAlarm)
        
        saveToPersistentStore()
    }
    
    //update
    func updateAlarm(fireDate: Date, name: String, enabled: Bool, alarm: Alarm) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        
        saveToPersistentStore()
    }
    
    //delete
    func deleteAlarm(alarm: Alarm) {
        guard let alarmIndex = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: alarmIndex)
        cancelUserNotifications(for: alarm)
        
        saveToPersistentStore()
    }
    
    // MARK: Persistence
    
    private func fileUrl() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Alarm.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonAlarms = try jsonEncoder.encode(alarms)
            try jsonAlarms.write(to: fileUrl())
        } catch let encodingError {
            print("There was an error saving!! \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: fileUrl())
            let decodedAlarms = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedAlarms
        } catch let decodingError {
            print("There was an error decoding!! \(decodingError.localizedDescription)")
        }
    }
    
}
