//
//  SidebarView.swift
//  SwiftDuino
//
//  Created by Ethan Hanlon on 12/19/22.
//

import SwiftUI

struct SidebarView: View {
    let geometry: GeometryProxy
    let menu: Binding<String>
    @State private var serialDevices = findUSBDevicePaths()
    
    var body: some View {
        ZStack {
            Color(red: 0.2, green: 0.2, blue: 0.2)
                .ignoresSafeArea()
            VStack {
                // Dropdown
                Menu {
                    ForEach(serialDevices, id: \.self) { device in
                        Button(device) {
                            // Connect to device
                        }
                    }
                } label: {
                    Text("Serial Devices")
                }
                // Sidebar
                ForEach(serialDevices, id: \.self) { menu in
                    Text(menu)
                }
            }
            
        }
        .onAppear {
            // Get serial devices, populate serialDevices
//            let serial = SerialPo
        }
        
    }
}

struct SidebarView_Previews: PreviewProvider {
    // .constant(val) is a good way to pass in binding values
    static var previews: some View {
        GeometryReader { geometry in
            SidebarView(geometry: geometry, menu: .constant("Main"))
        }
    }
}
