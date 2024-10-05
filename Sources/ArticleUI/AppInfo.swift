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
@available(watchOS 11, *)
@available(*, deprecated, message: "use `AppDescriptionContent(name: LocalizedStringKey, iconName: String, id: String, @ViewBuilder content: () -> Content)`")
public struct AppInfo {
    let name: LocalizedStringKey
    let imageName: String
    let id: String
    
    public init(name: String, imageName: String, id: String) {
        self.name = LocalizedStringKey(name)
        self.imageName = imageName
        self.id = id
    }
}
#endif
