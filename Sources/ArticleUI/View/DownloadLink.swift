//
//  DownloadLink.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/11.
//

import SwiftUI

/// A button that takes the user to a specific app page in the App Store.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct DownloadLink: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private var id: String
    
    private var name: LocalizedStringKey
    
    private var downloadLinkStyle: DownloadLinkStyle
    
    /// Launch the App Store and create a link to open the page for the specified App ID.
    /// - Parameter id: App Id determined by App Store Connect
    public init(id: String) {
        self.id = id
        self.name = LocalizedStringKey("Download")
        self.downloadLinkStyle = .automatic
    }
    
    /// Launch the App Store and create a link to open the page for the specified App ID.
    /// - Parameters:
    ///   - id: App Id determined by App Store Connect
    ///   - name: App Name
    public init(
        id: String,
        name: LocalizedStringKey
    ) {
        self.id = id
        self.name = LocalizedStringKey("Download \(Text(name, bundle: .main))")
        self.downloadLinkStyle = .automatic
    }
    
    internal init(
        id: String,
        name: LocalizedStringKey,
        downloadLinkStyle: DownloadLinkStyle
    ) {
        self.id = id
        self.name = LocalizedStringKey("Download \(Text(name, bundle: .main))")
        self.downloadLinkStyle = downloadLinkStyle
    }
    
    public var body: some View {
        Link(
            destination: URL(
                string: "https://apps.apple.com/app/\(id)"
            )!
        ){
            if downloadLinkStyle == .light {
                Image("LightDownload", bundle: Bundle.module)
            } else if downloadLinkStyle == .dark {
                Image("DarkDownload", bundle: Bundle.module)
            } else {
                Image(
                    colorScheme == .dark ? "DarkDownload" : "LightDownload",
                    bundle: Bundle.module
                )
            }
        }
        .accessibilityLabel(Text(name ,bundle: .module))
    }
    
    /// Sets the given style for DownloadLinks within the view hierarchy
    /// - Parameter style: The style to set.
    /// - Returns: A view that uses the specified download button style
    public func downloadLinkStyle(_ style: DownloadLinkStyle) -> some View {
        Self.init(id: id, name: name, downloadLinkStyle: style)
    }
}
#if !os(watchOS) && !os(tvOS)
#Preview("Light Mode") {
    DownloadLink(id: "id6477782786")
        .environment(\.colorScheme, .light)
}

#Preview("Dark Mode") {
    DownloadLink(id: "id6477782786")
        .environment(\.colorScheme, .dark)
}
#endif
