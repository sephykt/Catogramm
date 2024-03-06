//
//  FeedView.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 23.07.2023.
//

import SwiftUI

struct FeedView: View {

    @StateObject var viewModel = FeedViewModel(service: CatService())

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case let .success(cats):
                List(cats) { cat in
                    FeedRowView(cat: cat)
                        .navigationTitle("Cats")
                }
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await viewModel.getCats()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
