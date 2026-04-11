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
    @ScaledMetric(relativeTo: .largeTitle) private var iconSize: CGFloat = 100
    @ScaledMetric(relativeTo: .largeTitle) private var columnWidth: CGFloat = 150

    private var name: LocalizedStringKey

    private var iconName: String

    private var id: String

    private var content: Content

    private var downloadLinkStyle: DownloadLinkStyle

    let gradient = Gradient(stops: [
        .init(color: Color(red: 48 / 255, green: 48 / 255, blue: 48 / 255), location: 0.0),
        .init(color: Color(red: 21 / 255, green: 21 / 255, blue: 21 / 255), location: 1.0)
    ])

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
    
    private var isAccessibilitySize: Bool {
        dynamicTypeSize.isAccessibilitySize
    }

    public var body: some View {
        if dynamicTypeSize > .xLarge || horizontalSizeClass == .compact {
            VStack(alignment: .leading, spacing: 10) {
                headerSection
                descriptionSection(alignment: isAccessibilitySize ? .center : .trailing)
            }
        } else {
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .center) {
                    iconView
                        .padding(.horizontal, iconSize * 0.097)
                        .padding(.vertical, (iconSize * 0.097) + 10)

                    nameText
                }
                .frame(width: columnWidth)
                .frame(maxHeight: .infinity, alignment: .center)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(name, bundle: .main))
                .accessibilityAddTraits(.isImage)

                descriptionSection(alignment: .trailing)
            }
            .padding(.vertical, 15)
        }
    }
    
    private var headerSection: some View {
        Group {
            if isAccessibilitySize {
                VStack(alignment: .center, spacing: 8) {
                    iconView
                    nameText
                }
            } else {
                HStack(alignment: .center) {
                    iconView
                    Spacer()
                    nameText
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(name, bundle: .main))
        .accessibilityAddTraits(.isImage)
    }

    private func descriptionSection(alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 10) {
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
        .frame(maxWidth: .infinity, alignment: Alignment(horizontal: alignment, vertical: .center))
    }

    @ViewBuilder
    private var iconView: some View {
#if os(visionOS)
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: iconSize * 0.903)
            .clipShape(Circle())
#elseif os(iOS)
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: iconSize * 0.903)
            .background {
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: iconSize * 0.903 * 0.2237)
            )
#else
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: iconSize * 0.903)
#endif
    }

    private var nameText: some View {
        Text(name, bundle: .main)
            .font(.subheadline)
            .bold()
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

#Preview("Compact Layout", traits: .sizeThatFitsLayout) {
    AppDescriptionContent(
        iconName: "AppIcon",
        name: "Sample App",
        id: "id0000000000"
    ) {
        Text("This is a sample app description for preview purposes.")
    }
    .environment(\.horizontalSizeClass, .compact)
    .padding()
}

#Preview("Regular Layout", traits: .sizeThatFitsLayout) {
    AppDescriptionContent(
        iconName: "AppIcon",
        name: "Sample App",
        id: "id0000000000"
    ) {
        Text("This is a sample app description for preview purposes.")
    }
    .environment(\.horizontalSizeClass, .regular)
    .padding()
}

#Preview("Extra Large Dynamic Type", traits: .sizeThatFitsLayout) {
    AppDescriptionContent(
        iconName: "AppIcon",
        name: "Sample App",
        id: "id0000000000"
    ) {
        Text("This is a sample app description for preview purposes.")
    }
    .environment(\.dynamicTypeSize, .xxxLarge)
    .padding()
}

#Preview("Accessibility Dynamic Type", traits: .sizeThatFitsLayout) {
    AppDescriptionContent(
        iconName: "AppIcon",
        name: "Sample App",
        id: "id0000000000"
    ) {
        Text("This is a sample app description for preview purposes.")
    }
    .environment(\.dynamicTypeSize, .accessibility3)
    .padding()
}
#endif
