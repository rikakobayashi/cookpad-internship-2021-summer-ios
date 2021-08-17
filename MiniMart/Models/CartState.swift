//
//  CartState.swift
//  MiniMart
//
//  Created by 小林莉華 on 2021/08/17.
//

import Foundation
import Combine

struct CartItem {
    var product: FetchProductsQuery.Data.Product
    var quantity: Int
}

final class CartState: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func addProductToCart(product: FetchProductsQuery.Data.Product) {
        if let i = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            var cartItem = cartItems[i]
            cartItem.quantity += 1
            cartItems[i] = cartItem
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func getTotalPrice() -> Int {
        let totalPrice = cartItems.reduce(0, {(sum, item: CartItem) -> Int in
            return sum + item.quantity * item.product.price
        })
        return totalPrice
    }
    
    func getCartCount() -> Int {
        let cartCount  = cartItems.reduce(0, {(sum, item: CartItem) -> Int in
            return sum + item.quantity
        })
        return cartCount
    }
    
    func clear() {
        cartItems = []
    }
}
