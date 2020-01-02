//
//  ItemDetail.swift
//  iDine
//
//  Created by Gavin Butler on 30-12-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    var item: MenuItem
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description).padding()
            Button(action: {
                self.order.add(item: self.item)
            }) {
                Text("Order This")
                    
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(10)
                    //.border(Color.blue, width: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30.0)
                            .stroke(Color.blue, lineWidth: 5)
                    )
            }
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                print("Favourite pressed")
                item.favourite = true
            }) {
                Image(systemName: "star.fill")
            }
        )
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example).environmentObject(order)
        }
    }
}
