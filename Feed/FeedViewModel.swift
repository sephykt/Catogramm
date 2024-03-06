//
//  FeedViewModel.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 23.07.2023.
//

import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {

    enum State {
        case notAvailable
        case loading
        case success(data: [CatModel])
        case failed(error: Error)
    }

    @Published private(set) var state: State = .notAvailable
    @Published var imageViewModel: CatImageModel?

    private let service: CatService

    init(service: CatService) {
        self.service = service
    }

    func getCats() async {
        self.state = .loading

        do {
            let cats = try await service.fetchCats()
            self.state = .success(data: cats)
        } catch {
            self.state = .failed(error: error)
        }
    }
}
