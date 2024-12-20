//
//  DownloadLinkStyle.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/11.
//


/// A structl that describes the appearance of an DownloadLink.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct DownloadLinkStyle: Equatable {
    private var downloadLinkStyleType: DownloadLinkStyleType
    
    private init(_ downloadLinkStyleType: DownloadLinkStyleType) {
        self.downloadLinkStyleType = downloadLinkStyleType
    }
    
    /// Styles to be varied according to the appearance mode of the system
    public static var automatic: DownloadLinkStyle {
        get {
            DownloadLinkStyle(.automatic)
        }
    }
    
    /// Light Mode Style
    public static var light: DownloadLinkStyle {
        get {
            DownloadLinkStyle(.light)
        }
    }
    
    /// Dark Mode Style
    public static var dark: DownloadLinkStyle {
        get {
            DownloadLinkStyle(.dark)
        }
    }
}

private enum DownloadLinkStyleType: Equatable {
    case automatic
    case light
    case dark
}
