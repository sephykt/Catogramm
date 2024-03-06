//
//  CatService.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 24.07.2023.
//

import Foundation

struct CatService {

    enum CatServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
        case urlFailed
    }

    func fetchCats() async throws -> [CatModel] {
        guard let url = URL(string: Endpoints.breeds) else {
            throw CatServiceError.urlFailed
        }
        var request = URLRequest(url: url)
        request.setValue("live_kFwn6oQvVGU7dpVb0H1HCbFOHZyQDxo2HHwLkGNL659NCKqWUfGFQsYbwJJgMD5G", forHTTPHeaderField: "x-api-key")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CatServiceError.invalidStatusCode
        }

        let decodedData = try JSONDecoder().decode([CatModel].self, from: data)
        return decodedData
    }

    func fetchCatImages(params: [String: String?]) async throws -> [CatImageModel] {
        guard let url = URL(string: Endpoints.fetchImages + params.toQueryString()) else {
            throw CatServiceError.urlFailed
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CatServiceError.invalidStatusCode
        }
        let decodedData = try JSONDecoder().decode([CatImageModel].self, from: data)
        return decodedData
    }

    func fetchCat(by id: String) async throws -> CatModel {
        guard let url = URL(string: Endpoints.breeds + "/\(id)") else {
            throw CatServiceError.urlFailed
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CatServiceError.invalidStatusCode
        }
        let decodedData = try JSONDecoder().decode(CatModel.self, from: data)
        return decodedData
    }
}
