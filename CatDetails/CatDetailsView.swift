//
//  CatDetailsView.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 23.07.2023.
//

import SwiftUI

struct CatDetailsView: View {

    var catModel: CatModel
    var imageModel: CatImageModel?
    @StateObject var viewModel = CatDetailsViewModel(service: CatService())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let imageModel = imageModel, let url = URL(string: imageModel.url) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case let .success(image):
                            image
                                .resizable()
                                .aspectRatio(CGSize(
                                    width: Double(imageModel.width),
                                    height: Double(imageModel.height)), contentMode: .fit)
                                .cornerRadius(12)
                        case .failure:
                            Image(systemName: "wifi.slash")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                Text("\(viewModel.cat?.name ?? "")")
                    .fontWeight(.bold)
                Text("\(viewModel.cat?.description ?? "")")
                    .fontWeight(.light)
                Spacer()
                if let wikiURL = catModel.wikipediaURL, let url = URL(string: wikiURL) {
                    Link("Visit Wikipedia", destination: url)
                }
            }
            .padding()
            .task {
                await viewModel.fetchCat(by: catModel.id)
            }
        }
        .navigationTitle(catModel.name)
    }
}
