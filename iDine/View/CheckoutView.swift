//
//  CheckoutView.swift
//  iDine
//
//  Created by Gavin Butler on 01-01-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    
    // Picker Variables
    @State private var paymentType = 0
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    
    //Loyalty card details
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    
    //Segmented Control Variables
    static let tipPercentages = [10, 15, 20, 25, 0]
    @State private var tipPercentageIndex = 1
    
    //Alert variables
    @State private var showingPaymentAlert = false
    
    //Pickup Time variables:
    @State private var pickupTime = 0
    static let pickupTimes = ["Now", "Tonight", "Tomorrow Morning"]
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipPercentages[tipPercentageIndex])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(0..<Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $addLoyaltyDetails.animation(.spring())) {
                    Text("Add iDine loyalty card")
                }
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipPercentageIndex) {
                    ForEach(0..<Self.tipPercentages.count) { index in
                        Text("\(Self.tipPercentages[index])%")
                    }
                }
                //Segments can be text or pictures; anything else will silently fail.
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Pickup Time:").font(.custom("Arial", size: 25.0))) {
                Picker("What time to pick up?", selection: $pickupTime) {
                    ForEach(0..<Self.pickupTimes.count) {
                        Text(Self.pickupTimes[$0])
                    }
                }
            }
            Section(header: Text("TOTAL: \(totalPrice, specifier: "%.2f")")
                .font(.largeTitle)) {
                Button("Confirm order") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payment: \(CheckoutView.paymentTypes[paymentType])"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%.2f") - thankyou!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
