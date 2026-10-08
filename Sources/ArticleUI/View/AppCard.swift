//
//  AppCard.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import SwiftUI
#if os(iOS) || os(visionOS)
import StoreKit
#endif

#if !os(tvOS) && !os(watchOS)
/// View to add app title, icon and description.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AppCard<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.colorScheme) private var colorScheme
    @ScaledMetric(relativeTo: .largeTitle) private var iconSize: CGFloat = 60
    @State private var isDetailPresented = false
#if os(iOS) || os(visionOS)
    @State private var isOverlayPresented = false
#endif

    private var name: LocalizedStringKey

    private var subtitle: LocalizedStringKey

    private var iconSource: AppIconSource

    private var appID: String

    private var content: Content

    private var downloadLinkStyle: DownloadLinkStyle

    /// View to introduce the app
    /// - Parameters:
    ///   - app: Variables with basic information about the app
    ///   - content: View describing the app
    public init(
        app: AppInfo,
        @ViewBuilder content: () -> Content,
        downloadLinkStyle: DownloadLinkStyle = .automatic
    ) {
        self.name = LocalizedStringKey(app.name)
        self.subtitle = LocalizedStringKey(app.subtitle)
        self.iconSource = app.image
        self.appID = app.id
        self.content = content()
        self.downloadLinkStyle = downloadLinkStyle
    }

    /// View to introduce the app
    /// - Parameters:
    ///   - name: App Name
    ///   - subtitle: A one-line phrase that describes the app, shown below the name
    ///   - iconName: Name of the asset for the application icon
    ///   - appID: App ID as listed in the App Store
    ///   - content: View describing the app
    public init(
        name: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        iconName: String,
        appID: String,
        @ViewBuilder content: () -> Content,
        downloadLinkStyle: DownloadLinkStyle = .automatic
    ) {
        self.name = name
        self.subtitle = subtitle
        self.iconSource = .asset(name: iconName, bundle: nil)
        self.appID = appID
        self.content = content()
        self.downloadLinkStyle = downloadLinkStyle
    }

    /// View to introduce the app
    /// - Parameters:
    ///   - name: App Name
    ///   - subtitle: A one-line phrase that describes the app, shown below the name
    ///   - iconURL: URL of a remotely hosted image to use as the application icon
    ///   - appID: App ID as listed in the App Store
    ///   - content: View describing the app
    public init(
        name: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        iconURL: String,
        appID: String,
        @ViewBuilder content: () -> Content,
        downloadLinkStyle: DownloadLinkStyle = .automatic
    ) {
        self.name = name
        self.subtitle = subtitle
        self.iconSource = .staticURL(URL(string: iconURL))
        self.appID = appID
        self.content = content()
        self.downloadLinkStyle = downloadLinkStyle
    }

    /// View to introduce the app
    /// - Parameters:
    ///   - name: App Name
    ///   - subtitle: A one-line phrase that describes the app, shown below the name
    ///   - lightIconURL: URL of a remotely hosted image to use as the application icon in light appearance
    ///   - darkIconURL: URL of a remotely hosted image to use as the application icon in dark appearance
    ///   - appID: App ID as listed in the App Store
    ///   - content: View describing the app
    public init(
        name: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        lightIconURL: String,
        darkIconURL: String,
        appID: String,
        @ViewBuilder content: () -> Content,
        downloadLinkStyle: DownloadLinkStyle = .automatic
    ) {
        self.name = name
        self.subtitle = subtitle
        self.iconSource = .adaptiveURL(light: URL(string: lightIconURL), dark: URL(string: darkIconURL))
        self.appID = appID
        self.content = content()
        self.downloadLinkStyle = downloadLinkStyle
    }

    internal init(
        name: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        iconSource: AppIconSource,
        appID: String,
        content: Content,
        downloadLinkStyle: DownloadLinkStyle = .automatic
    ) {
        self.name = name
        self.subtitle = subtitle
        self.iconSource = iconSource
        self.appID = appID
        self.content = content
        self.downloadLinkStyle = downloadLinkStyle
    }
    
    private var isAccessibilitySize: Bool {
        dynamicTypeSize.isAccessibilitySize
    }

    public var body: some View {
        ViewThatFits(in: .horizontal) {
            ZStack(alignment: .leading) {
                Button {
                    isDetailPresented = true
#if os(iOS) || os(visionOS)
                    isOverlayPresented = true
#endif
                } label: {
                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    subtitle == ""
                        ? Text(name, bundle: .main)
                        : Text(name, bundle: .main) + Text(" ") + Text(subtitle, bundle: .main)
                )

                HStack(alignment: .center, spacing: 10) {
                    Group {
                        if isAccessibilitySize {
                            VStack(alignment: .leading, spacing: 8) {
                                switch iconSource {
                                case .asset(let assetName, let bundle):
                                    Image(assetName, bundle: bundle)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: iconSize * 0.903)
                                case .staticURL(let url):
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                                case .adaptiveURL(let light, let dark):
                                    AsyncImage(url: colorScheme == .dark ? dark : light) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(name, bundle: .main)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)

                                    if subtitle != "" {
                                        Text(subtitle, bundle: .main)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        } else {
                            switch iconSource {
                            case .asset(let assetName, let bundle):
                                Image(assetName, bundle: bundle)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: iconSize * 0.903)
                            case .staticURL(let url):
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                            case .adaptiveURL(let light, let dark):
                                AsyncImage(url: colorScheme == .dark ? dark : light) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(name, bundle: .main)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)

                                if subtitle != "" {
                                    Text(subtitle, bundle: .main)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)

                    Spacer(minLength: 10)

                    DownloadLink(
                        id: appID,
                        name: name,
                        downloadLinkStyle: downloadLinkStyle
                    )
                }
            }

            ZStack(alignment: .top) {
                Button {
                    isDetailPresented = true
#if os(iOS) || os(visionOS)
                    isOverlayPresented = true
#endif
                } label: {
                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    subtitle == ""
                        ? Text(name, bundle: .main)
                        : Text(name, bundle: .main) + Text(" ") + Text(subtitle, bundle: .main)
                )

                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        if isAccessibilitySize {
                            VStack(alignment: .leading, spacing: 8) {
                                switch iconSource {
                                case .asset(let assetName, let bundle):
                                    Image(assetName, bundle: bundle)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: iconSize * 0.903)
                                case .staticURL(let url):
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                                case .adaptiveURL(let light, let dark):
                                    AsyncImage(url: colorScheme == .dark ? dark : light) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(name, bundle: .main)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)

                                    if subtitle != "" {
                                        Text(subtitle, bundle: .main)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        } else {
                            HStack(alignment: .center, spacing: 10) {
                                switch iconSource {
                                case .asset(let assetName, let bundle):
                                    Image(assetName, bundle: bundle)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: iconSize * 0.903)
                                case .staticURL(let url):
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                                case .adaptiveURL(let light, let dark):
                                    AsyncImage(url: colorScheme == .dark ? dark : light) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            Image(systemName: "app.dashed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .frame(width: iconSize * 0.903, height: iconSize * 0.903)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(name, bundle: .main)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)

                                    if subtitle != "" {
                                        Text(subtitle, bundle: .main)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)

                    DownloadLink(
                        id: appID,
                        name: name,
                        downloadLinkStyle: downloadLinkStyle
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .sheet(isPresented: $isDetailPresented, onDismiss: {
#if os(iOS) || os(visionOS)
            isOverlayPresented = false
#endif
        }) {
            AppDetailView(
                name: name,
                subtitle: subtitle,
                iconSource: iconSource,
                id: appID,
                content: content,
                downloadLinkStyle: downloadLinkStyle
            )
        }
#if os(iOS) || os(visionOS)
        .appStoreOverlay(isPresented: $isOverlayPresented) {
            SKOverlay.AppConfiguration(
                appIdentifier: storeAppIdentifier,
                position: .bottom
            )
        }
#endif
    }

#if os(iOS) || os(visionOS)
    private var storeAppIdentifier: String {
        appID.hasPrefix("id") ? String(appID.dropFirst(2)) : appID
    }
#endif

    /// Sets the given style for DownloadLinks within the view hierarchy
    /// - Parameter style: The style to set.
    /// - Returns: A view that uses the specified download button style
    public func downloadLinkStyle(_ style: DownloadLinkStyle) -> some View {
        Self.init(
            name: name,
            subtitle: subtitle,
            iconSource: iconSource,
            appID: appID,
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
@available(*, deprecated, renamed: "AppCard")
public typealias AppDescriptionContent = AppCard

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(*, deprecated, renamed: "AppCard")
public typealias AppInfoContent = AppCard

#Preview("Regular Layout", traits: .sizeThatFitsLayout) {
    AppCard(
        name: "Sample App",
        subtitle: "A demo app for ArticleUI",
        iconSource: .asset(name: "AppIcon", bundle: .module),
        appID: "id0000000000",
        content: Text("Sample App is a demo application bundled with ArticleUI to verify how the library behaves in a real SwiftUI project. It shows Article and Section layouts, the AppCard view you're looking at right now, and the DownloadLink badge below, all rendered with ArticleUI's platform-adaptive styling."),
        downloadLinkStyle: .automatic
    )
    .padding()
}

#Preview("Extra Large Dynamic Type", traits: .sizeThatFitsLayout) {
    AppCard(
        name: "Sample App",
        subtitle: "A demo app for ArticleUI",
        iconSource: .asset(name: "AppIcon", bundle: .module),
        appID: "id0000000000",
        content: Text("Sample App is a demo application bundled with ArticleUI to verify how the library behaves in a real SwiftUI project. It shows Article and Section layouts, the AppCard view you're looking at right now, and the DownloadLink badge below, all rendered with ArticleUI's platform-adaptive styling."),
        downloadLinkStyle: .automatic
    )
    .environment(\.dynamicTypeSize, .xxxLarge)
    .padding()
}

#Preview("Accessibility Dynamic Type") {
    ScrollView {
        AppCard(
            name: "Sample App",
            subtitle: "A demo app for ArticleUI",
            iconSource: .asset(name: "AppIcon", bundle: .module),
            appID: "id0000000000",
            content: Text("Sample App is a demo application bundled with ArticleUI to verify how the library behaves in a real SwiftUI project. It shows Article and Section layouts, the AppCard view you're looking at right now, and the DownloadLink badge below, all rendered with ArticleUI's platform-adaptive styling."),
            downloadLinkStyle: .automatic
        )
        .environment(\.dynamicTypeSize, .accessibility3)
        .padding()
    }
}
#endif
