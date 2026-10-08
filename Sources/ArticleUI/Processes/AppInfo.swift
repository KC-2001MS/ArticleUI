//
//  AppInfo.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import SwiftUI

#if !os(tvOS)
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AppInfo: Codable {
    let name: String
    let subtitle: String
    let image: AppIconSource
    let id: String
    let platforms: [AppPlatform]

    public init(
        name: String,
        subtitle: String = "",
        imageName: String,
        id: String,
        platforms: [AppPlatform] = []
    ) {
        self.name = name
        self.subtitle = subtitle
        self.image = .asset(name: imageName, bundle: nil)
        self.id = id
        self.platforms = platforms
    }

    public init(
        name: String,
        subtitle: String = "",
        imageURL: String,
        id: String,
        platforms: [AppPlatform] = []
    ) {
        self.name = name
        self.subtitle = subtitle
        self.image = .staticURL(URL(string: imageURL))
        self.id = id
        self.platforms = platforms
    }

    public init(
        name: String,
        subtitle: String = "",
        lightImageURL: String,
        darkImageURL: String,
        id: String,
        platforms: [AppPlatform] = []
    ) {
        self.name = name
        self.subtitle = subtitle
        self.image = .adaptiveURL(light: URL(string: lightImageURL), dark: URL(string: darkImageURL))
        self.id = id
        self.platforms = platforms
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case subtitle
        case image
        case id
        case platforms
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        self.image = try container.decode(AppIconSource.self, forKey: .image)
        self.id = try container.decode(String.self, forKey: .id)
        self.platforms = try container.decodeIfPresent([AppPlatform].self, forKey: .platforms) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(image, forKey: .image)
        try container.encode(id, forKey: .id)
        try container.encode(platforms, forKey: .platforms)
    }
}
#endif
