//
//  HomeViewModel.swift
//  Demo
//
//  Created by MUNAVAR PM on 02/04/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    
    var filterBySearch: [Product] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter({ $0.title.localizedCaseInsensitiveContains(searchText)})
        }
    }
    var count: Int {
        products.count
    }
    
    func fetchProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        self.products = try JSONDecoder().decode([Product].self, from: data)
                        print("Data = \(self.products)")
                    } catch {
                        print("Errrorrr = \(error)")
                    }
                }
            }
        }.resume()
    }
}
