//
//  Font+.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/13.
//

import SwiftUI

// TODO: Supports Dynamic Type while minimizing differences in appearance by platform
internal extension Font {
    static var articleHeader: Font {
#if os(macOS)
        let baseFont = NSFont.systemFont(ofSize: 17, weight: .bold)
                
                // macOSではダイナミックタイプをシステム自体がサポートしないため、ユーザー設定に基づく
        let scaledFont = NSFontManager.shared.convert(baseFont, toSize: NSFont.systemFontSize(for: .regular))
                
                // NSFontをCTFontに変換して返す
                return Font(scaledFont)
#elseif os(watchOS) || os(tvOS)
        let textStyle = UIFont.TextStyle.title1
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        
        // ベースフォントを作成し、ダイナミックタイプでサイズ調整
        let baseFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        let scaledFont = fontMetrics.scaledFont(for: baseFont)
        
        // UIFontをCTFontに変換して返す
        return Font(scaledFont)
#else
        let textStyle = UIFont.TextStyle.title1
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)

        let baseFont = UIFont.systemFont(ofSize: 28, weight: .regular)
        let scaledFont = fontMetrics.scaledFont(for: baseFont)

        return Font(scaledFont)
#endif
    }
}
