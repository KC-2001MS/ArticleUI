//
//  AppIconSource.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import Foundation

#if !os(tvOS)
/// The origin of the image used as an app's icon.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
internal enum AppIconSource: Codable {
    case asset(name: String, bundle: Bundle?)
    case staticURL(URL?)
    case adaptiveURL(light: URL?, dark: URL?)

    private enum CodingKeys: String, CodingKey {
        case kind
        case name
        case url
        case lightURL
        case darkURL
    }

    private enum Kind: String, Codable {
        case asset
        case url
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(Kind.self, forKey: .kind) {
        case .asset:
            let name = try container.decode(String.self, forKey: .name)
            self = .asset(name: name, bundle: nil)
        case .url:
            if let darkString = try container.decodeIfPresent(String.self, forKey: .darkURL) {
                let lightString = try container.decode(String.self, forKey: .lightURL)
                self = .adaptiveURL(light: URL(string: lightString), dark: URL(string: darkString))
            } else {
                let urlString = try container.decode(String.self, forKey: .url)
                self = .staticURL(URL(string: urlString))
            }
        }
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .asset(let name, _):
            try container.encode(Kind.asset, forKey: .kind)
            try container.encode(name, forKey: .name)
        case .staticURL(let url):
            try container.encode(Kind.url, forKey: .kind)
            try container.encode(url?.absoluteString, forKey: .url)
        case .adaptiveURL(let light, let dark):
            try container.encode(Kind.url, forKey: .kind)
            try container.encode(light?.absoluteString, forKey: .lightURL)
            try container.encode(dark?.absoluteString, forKey: .darkURL)
        }
    }
}
#endif
