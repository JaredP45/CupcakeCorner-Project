//
//  CheckoutView.swift
//  CupcakeCorner-Project
//
//  Created by Jared Paubel on 4/21/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//


import SwiftUI

enum AlertType {
    case confirmation
    case error
}


struct CheckoutView: View {
    @ObservedObject var OO: ObservOrder
    
    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State private var alertType = AlertType.confirmation
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.OO.order.cost, specifier:"%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        
        .alert(isPresented: $showingAlert) { () -> Alert in
            switch alertType {
            case .confirmation:
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            case .error:
                return Alert(title: Text("Error!"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(OO.order) else {
            self.show(error: "Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.show(error: "No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.show(confirmation: "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!")
            } else {
                self.show(error: "Invalide response from server")
            }
        }.resume()
    }
    
    
    func show(error: String) {
        self.errorMessage = error
        self.alertType = .error
        self.showingAlert = true
    }
    
    func show(confirmation: String) {
        self.confirmationMessage = confirmation
        self.alertType = .confirmation
        self.showingAlert = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(OO: ObservOrder(order: Order()))
    }
}
