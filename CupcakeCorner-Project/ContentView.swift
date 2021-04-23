//
//  ContentView.swift
//  CupcakeCorner-Project
//
//  Created by Jared Paubel on 4/21/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var OO = ObservOrder(order: Order())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $OO.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $OO.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(OO.order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $OO.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if OO.order.specialRequestEnabled {
                        Toggle(isOn: $OO.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $OO.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination:
                    AddressView(OO: OO)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
