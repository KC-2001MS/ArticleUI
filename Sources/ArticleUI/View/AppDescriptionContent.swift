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
    
    private var downloadLinkStyle: DownloadLinkStyle

    /// View to introduce the app
    /// - Parameters:
    ///   - app: Variables with basic information about the app
    ///   - content: View describing the app
    @available(
        *,
         deprecated,
         message: "use `init(name: LocalizedStringKey, iconName: String, id: String, @ViewBuilder content: () -> Content)`"
    )
    public init(
        app: AppInfo,
        @ViewBuilder content: () -> Content
    ) {
        self.name = app.name
        self.iconName = app.imageName
        self.id = app.id
        self.content = content()
        self.downloadLinkStyle = .automatic
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
        self.downloadLinkStyle = .automatic
    }
    
    internal init(
        iconName: String,
        name: LocalizedStringKey,
        id: String,
        content: Content,
        downloadLinkStyle: DownloadLinkStyle
    ) {
        self.name = name
        self.iconName = iconName
        self.id = id
        self.content = content
        self.downloadLinkStyle = downloadLinkStyle
    }
    
    public var body: some View {
        if dynamicTypeSize > .xLarge || horizontalSizeClass == .compact {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    #if os(visionOS)
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * 0.903)
                        .clipShape(Circle())
                        .padding(.all, 100 * 0.097)
#elseif os(iOS)
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * 0.903)
                        .clipShape(RoundedRectangle(cornerRadius: 100 * 0.903 * 0.2237))
                        .padding(.all, 100 * 0.097)
                    #else
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    #endif
                    
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
                    
                    DownloadLink(
                        id: id,
                        name: name,
                        downloadLinkStyle: downloadLinkStyle
                    )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .center) {
#if os(visionOS)
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * 0.903)
                        .clipShape(Circle())
                        .padding(.horizontal, 100 * 0.097)
                        .padding(.vertical, (100 * 0.097) + 10)
#elseif os(iOS)
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * 0.903)
                        .clipShape(RoundedRectangle(cornerRadius: 100 * 0.903 * 0.2237))
                        .padding(.horizontal, 100 * 0.097)
                        .padding(.vertical, (100 * 0.097) + 10)
#else
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * 0.903)
                        .padding(.horizontal, 100 * 0.097)
                        .padding(.vertical, (100 * 0.097) + 10)
#endif
                    
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
                    
                    DownloadLink(
                        id: id,
                        name: name,
                        downloadLinkStyle: downloadLinkStyle
                    )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 15)
        }
    }
    
    /// Sets the given style for DownloadLinks within the view hierarchy
    /// - Parameter style: The style to set.
    /// - Returns: A view that uses the specified download button style
    public func downloadLinkStyle(_ style: DownloadLinkStyle) -> some View {
        Self.init(
            iconName: iconName,
            name: name,
            id: id,
            content: content,
            downloadLinkStyle: style
        )
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
