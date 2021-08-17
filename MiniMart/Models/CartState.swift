//
//  CartState.swift
//  MiniMart
//
//  Created by 小林莉華 on 2021/08/17.
//

import Foundation
import Combine

final class CartState: ObservableObject {
    @Published var products: [FetchProductsQuery.Data.Product] = []
    func addProductToCart(product: FetchProductsQuery.Data.Product) {
        products.append(product)
    }
}
