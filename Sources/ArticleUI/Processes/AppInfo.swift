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
@available(*, deprecated, message: "use `AppDescriptionContent(name: LocalizedStringKey, iconName: String, id: String, @ViewBuilder content: () -> Content)`")
public struct AppInfo {
    let name: LocalizedStringKey
    let imageName: String
    let id: String
    
    public init(name: LocalizedStringKey, imageName: String, id: String) {
        self.name = name
        self.imageName = imageName
        self.id = id
    }
}
#endif
