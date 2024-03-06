//
//  CatImageModel.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 24.07.2023.
//

import SwiftUI

struct CatImageModel: Codable, Identifiable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

