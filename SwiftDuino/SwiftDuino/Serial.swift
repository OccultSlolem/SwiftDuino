//
//  Serial.swift
//  SwiftDuino
//
//  Created by Ethan Hanlon on 12/19/22.
//
import Foundation
import IOKit
import IOKit.serial
import SwiftSerial
import CoreFoundation


func connect(baudRate: Int = 9600, path: String) {
    let serial = SerialPort(path: path)
    
    serial.setSettings(
        receiveRate: .baud9600,
        transmitRate: .baud9600,
        minimumBytesToRead: 1
    )
    
    do {
        try serial.openPort()
    } catch {
        print("🤖🤯 Error opening serial port! Double check your connection and try again")
    }
}


func findUSBDevicePaths() -> [String] {
    print("Finding paths")
    var usbDevicePaths: [String] = []
    
    var usbIterator: io_iterator_t = 0
    let classesToMatch = IOServiceMatching("IOUSBDevice")
    guard let classesToMatch = classesToMatch else {
        print("🤖🤯 Error: Couldn't create a USB matching dictionary.")
        return usbDevicePaths
    }
    
    let result = IOServiceGetMatchingServices(kIOMainPortDefault, classesToMatch, &usbIterator)
    guard result == KERN_SUCCESS else {
        print("🤖🤯 Error: Couldn't find any matching USB devices.")
        return usbDevicePaths
    }
    print(result)
    while true {
        print("*")
        let usbService = IOIteratorNext(usbIterator)
        print("USB Service: \(usbService)")
        guard usbService != 0 else {
            break
        }
        
        // --------
        // Get all the properties for the USB device
        
        // Create a dictionary to hold the device's properties
        var deviceProperties: CFMutableDictionary
        // Get the property iterator for the device
        var propIter = UInt32(0)
        let result = IORegistryEntryCreateCFProperties(
            usbService,
            &deviceProperties,
            kCFAllocatorDefault,
            0
        )
        guard result == KERN_SUCCESS else {
            print("🤖🤯 Error: Couldn't get properties for USB device.")
            continue
        }
        
        // Iterate over all the device's properties
        while true {
            let property = IOIteratorNext(propIter)
            guard property != 0 else {
                break
            }
            
            // Get the key and value for the property
            let key = IORegistryEntryCreateCFProperty(property, "name" as CFString, kCFAllocatorDefault, 0)?.takeRetainedValue() as? String
            let value = IORegistryEntryCreateCFProperty(property, "value" as CFString, kCFAllocatorDefault, 0)?.takeRetainedValue()
            
            // Print the key and value
            print("Key: \(key ?? "") Value: \(value ?? "")")
        }
        // ---------
        
        var path: CFTypeRef?
        
        let result = IORegistryEntryCreateCFProperty(
            usbService,
            "IOName" as CFString,
            kCFAllocatorDefault,
            0
        )
        path = result?.takeUnretainedValue()
        if result?.takeUnretainedValue() as? Int32 == KERN_SUCCESS, let path = path {
            let pathString = CFStringCreateWithCString(
                kCFAllocatorDefault,
                path as? UnsafePointer<Int8>,
                CFStringBuiltInEncodings.UTF8.rawValue
            ) as String
            usbDevicePaths.append(pathString)
            print(pathString)
        }

        IOObjectRelease(usbService)
    }

    print("---")
    return usbDevicePaths
}

func printUSBDeviceProperties() {
    let matchingDictionaries: [[String: Any]] = IOServiceMatching("IOUSBDevice")
    var iterator: io_iterator_t = 0
    if (IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IOUSBDevice"), &iterator) == kIOReturnSuccess) {
        var device: io_object_t
        repeat {
            device = IOIteratorNext(iterator)
            if (device != 0) {
                let deviceInfo = IODeviceInfo(device)
                let keys = deviceInfo.allKeys()
                for key in keys {
                    let value = deviceInfo.getValue(forKey: key)
                    print("\(key): \(value)")
                }
            }
        } while (device != 0)
    }
}


