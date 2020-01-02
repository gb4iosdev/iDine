//
//  ApplicationView.swift
//  iDine
//
//  Created by Gavin Butler on 01-01-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ApplicationView: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
            }.tag(0)
            OrderView().tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
            }.tag(1)
        }
    }
}

struct ApplicationView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        ApplicationView().environmentObject(order)
    }
}
