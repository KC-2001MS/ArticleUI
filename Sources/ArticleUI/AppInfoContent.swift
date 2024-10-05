//
//  AppInfo.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import SwiftUI

#if !os(tvOS) && !os(watchOS)
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AppDescriptionContent<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var name: LocalizedStringKey
    
    var iconName: String
    
    var id: String
    
    var content: Content
    
    
    @available(*, deprecated, message: "use `init(name: LocalizedStringKey, iconName: String, id: String, @ViewBuilder content: () -> Content)`")
    public init(
        app: AppInfo,
        @ViewBuilder content: () -> Content
    ) {
        self.name = app.name
        self.iconName = app.imageName
        self.id = app.id
        self.content = content()
    }
    
    public init(
        iconName: String,
        name: LocalizedStringKey,
        id: String,
        @ViewBuilder content: () -> Content
    ) {
        self.name = name
        self.iconName = iconName
        self.id = id
        self.content = content()
    }
    
    public var body: some View {
        if dynamicTypeSize > .large || horizontalSizeClass == .compact {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    
                    Spacer()
                    
                    Text(name)
                        .bold()
                }
                .frame(maxWidth: .infinity,alignment: .center)
                
                VStack(alignment: .trailing, spacing: 10) {
                    content
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    Link(
                        destination: URL(
                            string: "https://apps.apple.com/app/\(id)"
                        )!
                    ){
                        Image("Download", bundle: Bundle.module)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .center) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(.vertical, 10)
                    
                    Text(name)
                }
                .frame(width: 150)
                .frame(maxHeight: .infinity, alignment: .center)
                
                
                VStack(alignment: .trailing, spacing: 10) {
                    content
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    Link(
                        destination: URL(
                            string: "https://apps.apple.com/app/\(id)"
                        )!
                    ){
                        Image("Download", bundle: Bundle.module)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

@available(*, deprecated, renamed: "AppDescriptionContent")
typealias AppInfoContent = AppDescriptionContent
#endif
