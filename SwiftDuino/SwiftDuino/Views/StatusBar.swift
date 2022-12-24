//
//  StatusBar.swift
//  SwiftDuino
//
//  Created by Ethan Hanlon on 12/19/22.
//

import Foundation
import SwiftUI

struct StatusBar: View {
    var body: some View {
        HStack {
            Text("Status")
            Spacer()
            Button(action: {
                print("settings")
            }) {
                Image(systemName: "gear")
            }
        }
        .padding()
        .background(Color.gray)
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 20)
        
    }
}

struct StatusBar_Previews: PreviewProvider {
    private let frame = NSScreen.main!.frame
    static var previews: some View {
        VStack {
            Text("Great content, bro! :)")
//                .background(Rectangle().frame(width:300, height: 200))
            
            Spacer()
        }
        .frame(minWidth: 800, minHeight: 600)
        .background(Color.pink)
        .overlay(
            StatusBar()
//                .frame(width: .infinity, height: 20)
                .position(x: 400, y: 600 - 20)
//              .position(x: frame.width / 2, y: frame - 20)
            )
        
    }
}
