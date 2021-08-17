//
//  ProductDetailPageView.swift
//  MiniMart
//
//  Created by 小林莉華 on 2021/08/17.
//

import SwiftUI

struct ProductDetailPageView: View {
    @State var isCartViewPresented: Bool = false
    @EnvironmentObject var cartState: CartState
    
    var product: FetchProductsQuery.Data.Product
    var body: some View {
        ScrollView {
            RemoteImage(urlString: product.imageUrl)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.system(size: 20))
                    .padding(.vertical, 10.0)
                Text("\(product.price)円")
                    .font(.system(size: 20))
                    .padding(.vertical, 10.0)
                Text(product.summary)
                    .padding(.vertical, 10.0)
                Button(action: {
                    cartState.addProductToCart(product: product)
                }){
                    Text("カートに追加")
                        .foregroundColor(Color.white)
                }
                .padding(.vertical, 16.0)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10.0)
            }.padding(10.0)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.isCartViewPresented = true
                }) {
                    VStack {
                        Image(systemName: "folder")
                        Text(cartState.getCartCount().description)
                    }
                }
            }
        }
        .sheet(isPresented: $isCartViewPresented) {
            NavigationView {
                CartPageView(isCartViewPresented: $isCartViewPresented)
            }
        }
    }
}

struct ProductDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailPageView(
                product: FetchProductsQuery.Data.Product(
                    id: UUID().uuidString,
                    name: "商品 \(1)",
                    price: 100,
                    summary: "おいしい食材 \(1)",
                    imageUrl: "https://image.mini-mart.com/dummy/1"
                )
            )
        }
        .environmentObject(CartState())
    }
}
