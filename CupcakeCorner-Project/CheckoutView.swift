//
//  CheckoutView.swift
//  CupcakeCorner-Project
//
//  Created by Jared Paubel on 4/21/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier:"%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        // FIXME place the order
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
