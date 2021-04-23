//
//  AddressView.swift
//  CupcakeCorner-Project
//
//  Created by Jared Paubel on 4/21/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var OO: ObservOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $OO.order.name)
                TextField("Street Address", text: $OO.order.streetAddress)
                TextField("City", text: $OO.order.city)
                TextField("Zip", text: $OO.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(OO: OO)) {
                    Text("Check out")
                }
            }
            .disabled(OO.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(OO: ObservOrder(order: Order()))
    }
}
