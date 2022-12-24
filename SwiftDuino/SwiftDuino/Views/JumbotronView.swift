//
//  JumbotronView.swift
//  SwiftDuino
//
//  Created by Ethan Hanlon on 12/19/22.
//

import SwiftUI
import AVKit

struct JumbotronView: View {
    @State private var camera: AVCaptureDevice? = nil
    @State private var cameras = []
    @State private var authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    @State var menu: String
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    func alertUser(_ title: String, _ message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if !granted {
                alertUser("Permission not granted", "I was unable to get camera access. You will not be able to see your cameras until it is granted.")
                return
            }
            
            authorizationStatus = .authorized
        }
    }

    private let frame = NSScreen.main!.frame
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
    }
}

struct JumbotronView_Previews: PreviewProvider {
    
    static var previews: some View {
        JumbotronView(menu: "mainn")
    }
}
