//
//  CatDetailsViewModel.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 23.07.2023.
//

import SwiftUI

@MainActor
final class CatDetailsViewModel: ObservableObject {

    @Published private(set) var cat: CatModel?
    private let service: CatService

    init(service: CatService) {
        self.service = service
    }

    func fetchCat(by id: String) async {
        do {
            let cat = try await service.fetchCat(by: id)
            self.cat = cat
        } catch {
            print(error)
        }
    }
}
