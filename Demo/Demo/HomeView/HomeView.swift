//
//  HomeView.swift
//  Demo
//
//  Created by MUNAVAR PM on 02/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    private let adaptiveColumn = [
            GridItem(.adaptive(minimum: 150))
        ]
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                    TextField("Search Products", text: $viewModel.searchText)
                        .foregroundStyle(Color.gray)
                        .padding(.leading, UIconstant.screenWidth * 0.02544529262)
                    Spacer()
                }
                .padding()
                .frame(width: UIconstant.screenWidth * 0.8905852417, height: UIconstant.screenWidth * 0.1017811705)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .padding(.horizontal, UIconstant.screenWidth * 0.09669211196)
                Group {
                    Text("Products")
                        .bold()
                        .font(.system(size: 40))
                        
                    Text("\(viewModel.count) products found")
                }
                .padding(.leading, UIconstant.screenWidth * 0.06615776081)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: adaptiveColumn, spacing: UIconstant.screenWidth * 0.02562340967) {
                        ForEach(viewModel.filterBySearch) { product in
                            ProductSingleView(
                                image: product.image,
                                name: product.title
                            )
                            
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.leading, UIconstant.screenWidth * 0.07124681934)
            }
        }
        .background(Color.gray.opacity(0.2)
            .ignoresSafeArea(.all))
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

#Preview {
    HomeView()
}

struct ProductSingleView: View {
    var image: String
    var name: String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .frame(width: UIconstant.screenWidth * 0.3816793893, height: UIconstant.screenWidth * 0.5597964377)
            } placeholder: {
                ProgressView()
            }
            Text("\(name)")
                .font(.system(size: 20))
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal, UIconstant.screenWidth * 0.07633587786)
        }
        
        .frame(width: UIconstant.screenWidth * 0.4580152672, height: UIconstant.screenWidth * 0.6615776081)
        .padding(.bottom)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
    }
}
struct UIconstant {
    static let screenWidth = UIScreen.main.bounds.size.width
}
