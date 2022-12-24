//
//  ContentView.swift
//  SwiftDuino
//
//  Created by Ethan Hanlon on 12/19/22.
//

import SwiftUI
import AppKit
import AVKit
import SwiftSerial

struct ContentView: View {
    @State private var selectedMenu = ""
    @State private var fqbns = [] // Fully Qualified Board Names (FQBNs)
    
    
    var body: some View {
//        VStack {
        GeometryReader() { geometry in
            HStack {
            
                SidebarView(geometry: geometry, menu: $selectedMenu)
                    .frame(width: geometry.size.width * 0.2)
                
                JumbotronView(menu: selectedMenu)
//                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height)
                    .position(x: geometry.size.width * 0.4, y: geometry.size.height / 2)
                
            }
            .overlay(
                StatusBar()
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 20)
            )
            
            
        }
        .frame(minWidth: 800, minHeight: 600)
            
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
