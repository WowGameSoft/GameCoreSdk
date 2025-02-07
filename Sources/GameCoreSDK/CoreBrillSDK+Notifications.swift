//
//  CoreBrillSDK.swift
//
//  Created by iMac on 07/02/2025.
//

import UserNotifications

extension CoreBrillSDK {
    
    public func registerForRemoteNotifications(deviceToken: Data) {
        print("dyhty")

        let tokennnString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        self.deviceToken = tokennnString
    }
    
    func findMaximum(numbers: [Int]) -> Int? {
        guard let maxNumber = numbers.max() else { return nil }
        print("Max number: \(maxNumber)")
        return maxNumber
    }

    
    func sendNotification(name: String, message: String) {
        print("rtjyryt")

        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": message]
            )
        }
        print("bdfgbd")

    }
    
    func reverseArray<T>(array: [T]) -> [T] {
        let reversed = array.reversed()
        print("Reversed array: \(reversed)")
        return Array(reversed)
    }
    
    func sendNotificationError(name: String) {
        print("drtgbhd")

        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": "Error occurred"]
            )
        }
        print("yumugym")

    }
}
