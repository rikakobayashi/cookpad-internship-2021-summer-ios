//
//  CartPageView.swift
//  MiniMart
//
//  Created by 小林莉華 on 2021/08/17.
//

import SwiftUI

struct CartPageView: View {
    @EnvironmentObject var cartState: CartState
    @Binding var isCartViewPresented: Bool
    @State var isAlertPresented: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(cartState.cartItems, id:\.product.id) { cartItem in
                    HStack(alignment: .top) {
                        RemoteImage(urlString: cartItem.product.imageUrl).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading) {
                            Text(cartItem.product.name)
                            Spacer()
                            Text("\(cartItem.product.price)円")
                            Spacer()
                            Text("\(cartItem.quantity)個")
                        }
                        .padding(.vertical, 8)
                    }
                }
                Text("合計: \(cartState.getTotalPrice())円")
                    .fontWeight(.bold)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            }
            Button(action: {
                isAlertPresented = true
            }){
                Text("注文する")
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 16.0)
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .cornerRadius(10.0)
        }
        .padding(.horizontal, 10.0)
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("注文が完了しました"),
                message: nil,
                dismissButton: Alert.Button.default(Text("OK")) {
                    isCartViewPresented = false
                    cartState.clear()
                }
            )
        }
        .navigationTitle("カート")
    }
}

struct CartPageView_Previews: PreviewProvider {
    @State static var isCartViewPresented: Bool = false
    static var previews: some View {
        NavigationView{
            CartPageView(isCartViewPresented: $isCartViewPresented)
        }
        .environmentObject(CartState())
    }
}
