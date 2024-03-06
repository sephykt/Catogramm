//
//  QueryString.swift
//  Catogramm
//
//  Created by Ayaal Ivanov on 24.07.2023.
//

import Foundation

extension Dictionary where Key == String, Value == String? {

    func toQueryString() -> String {
        if self.isEmpty {
            return ""
        }
        let queryItems: [URLQueryItem] = self.compactMap {
            guard let value = $0.value else { return nil }
            return URLQueryItem(name: $0.key, value: value)
        }
        var urlComponents = URLComponents()
        urlComponents.queryItems = queryItems
        return urlComponents.string ?? ""
    }
}
