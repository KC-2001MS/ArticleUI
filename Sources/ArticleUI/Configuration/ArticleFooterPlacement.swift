//
//  Position.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/12.
//

/// Display position of footer
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
@frozen
public enum ArticleFooterPlacement {
    case automatic
    case annotation
    case insideContent
    case afterContent
}
