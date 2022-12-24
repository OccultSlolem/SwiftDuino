//
//  Types.swift
//  SwiftDuino
//
//  Created by Ethan Hanlon on 12/19/22.
//

import Foundation

struct Robot: Identifiable {
    let id = UUID().uuidString
    var name: String
    var serialPort: String
    var baudRate: Int
    var connected = RobotConnectionStatus.disconnected
    var enabled = RobotEnableStatus.disabled
}

enum RobotEnableStatus {
    case enabled
    case emergencyStop
    case disabled
}

enum RobotConnectionStatus {
    case connected
    case connecting
    case disconnected
}

struct RobotCommand: Identifiable {
    let id = UUID().uuidString
    var name: String
    var command: String
}

struct RobotCommandGroup: Identifiable {
    let id = UUID().uuidString
    var name: String
    var commands: [RobotCommand]
}