//
//  AppInfo.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import SwiftUI

#if !os(tvOS) && !os(watchOS)
/// View to add app title, icon and description.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AppDescriptionContent<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var name: LocalizedStringKey
    
    private var iconName: String
    
    private var id: String
    
    private var content: Content
    
    
    /// View to introduce the app
    /// - Parameters:
    ///   - app: Variables with basic information about the app
    ///   - content: View describing the app
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
    
    /// View to introduce the app
    /// - Parameters:
    ///   - iconName: Name of the asset for the application icon
    ///   - name: App Name
    ///   - id: App ID as listed in the App Store
    ///   - content: View describing the app
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
        if dynamicTypeSize > .xLarge || horizontalSizeClass == .compact {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    
                    Spacer()
                    
                    Text(name, bundle: .main)
                        .font(.custom("", size: 13, relativeTo: .largeTitle))
                        .bold()
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity,alignment: .center)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(name, bundle: .main))
                
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
                    .accessibilityLabel(Text("Download \(Text(name, bundle: .main))",bundle: .module))
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
                    
                    Text(name, bundle: .main)
                        .font(.custom("", size: 13, relativeTo: .largeTitle))
                        .bold()
                        .lineLimit(2)
                }
                .frame(width: 150)
                .frame(maxHeight: .infinity, alignment: .center)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(name, bundle: .main))
                
                
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
                    .accessibilityLabel(Text("Download \(Text(name, bundle: .main))",bundle: .module))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 15)
        }
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(*, deprecated, renamed: "AppDescriptionContent")
public typealias AppInfoContent = AppDescriptionContent
#endif
