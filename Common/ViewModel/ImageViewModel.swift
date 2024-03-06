//
//  ImageViewModel.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 24.07.2023.
//

import SwiftUI

@MainActor
final class ImageViewModel: ObservableObject {

    @Published var imageViewModel: CatImageModel?

    private let service: CatService

    init(service: CatService) {
        self.service = service
    }

    func getImage(params: [String: String?]) async {
        do {
            let images = try await service.fetchCatImages(params: params)
            self.imageViewModel = images.first
        } catch {
            print(error)
        }
    }
}
