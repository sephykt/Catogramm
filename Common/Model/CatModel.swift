//
//  CatModel.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 23.07.2023.
//

import SwiftUI

struct CatModel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let imageID: String?
    let temperament: String
    let wikipediaURL: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageID = "reference_image_id"
        case temperament
        case wikipediaURL = "wikipedia_url"
    }
}
