//
//  FeedRowView.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 24.07.2023.
//

import SwiftUI

struct FeedRowView: View {

    var cat: CatModel

    @StateObject var imageViewModel = ImageViewModel(service: CatService())

    var body: some View {
        NavigationLink(destination: CatDetailsView(catModel: cat, imageModel: imageViewModel.imageViewModel)) {
            VStack(alignment: .leading, spacing: 12) {
                if let urlString = imageViewModel.imageViewModel?.url, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .failure:
                            Image(systemName: "wifi.slash")
                        case let .success(image):
                            image
                                .resizable()
                                .aspectRatio(CGSize(
                                    width: Double(imageViewModel.imageViewModel?.width ?? 0),
                                    height: Double(imageViewModel.imageViewModel?.height ?? 0)), contentMode: .fit)
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(cat.name)
                        .fontWeight(.bold)
                    Text(cat.temperament)
                        .fontWeight(.light)
                }
            }
            .task {
                await imageViewModel.getImage(params: ["breed_ids": cat.id])
            }
        }
    }
}
