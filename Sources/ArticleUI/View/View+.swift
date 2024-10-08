//
//  View+.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/07.
//

import SwiftUI

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public extension View {
    /// Applies an inset to the rows in an article.
    /// - Parameter insets: The EdgeInsets to apply to the edges of the view.
    /// - Returns: A view that uses the given edge insets when used as a article cell.
    func articleRowInsets(_ insets: EdgeInsets?) -> some View {
        containerValue(\.articleRowInsets, insets)
    }
    
    /// Sets a fixed tint color for content in an article.
    /// - Parameter tint: The color to use to tint the content. Use nil to avoid overriding the inherited tint.
    /// - Returns: View of the adapted result
    func articleItemTint(_ tint: Color?) -> some View {
        containerValue(\.articleItemTint, tint)
    }
    
    /// Sets the display mode for the separator associated with this specific row.
    /// - Parameter visibility: The visibility of this row’s separators.
    /// - Returns: View of the adapted result
    func articleRowSeparator(_ visibility: Bool) -> some View {
        containerValue(\.articleRowSeparatorVisibility, visibility)
    }
    
    /// Sets the tint color associated with a row.
    /// - Parameter color: The color to use to tint the row separators, or nil to use the default color for the current article style.
    /// - Returns: View of the adapted result
    func articleRowSeparatorTint(_ color: Color?) -> some View {
        containerValue(\.articleRowSeparatorTint, color)
    }
    
    /// Sets the tint color associated with a section.
    /// - Parameter color: The color to use to tint the section separators, or nil to use the default color for the current article style.
    /// - Returns: View of the adapted result
    func articleSectionHeaderTint(_ color: Color?) -> some View {
        containerValue(\.articleSectionHeaderTint, color)
    }
    
    /// Sets the vertical spacing between two adjacent rows in an Article
    /// - Parameter spacing: The spacing value to use. A value of nil uses the default spacing.
    /// - Returns: View of the adapted result
    func articleRowSpacing(_ spacing: CGFloat) -> some View {
        containerValue(\.articleRowSpacing, spacing)
    }
    
    /// Sets the spacing between adjacent sections in a ``Article`` to a custom value.
    /// - Parameter spacing: The amount of spacing to apply.
    /// - Returns: View of the adapted result
    func articleSectionSpacing(_ spacing: CGFloat) -> some View {
        containerValue(\.articleSectionSpacing, spacing)
    }
    
    /// Whether to place the Footer at the bottom
    /// - Parameter isSticky: Boolean value of whether to place
    /// - Returns: View of the adapted result
    func stickyFooter(_ isSticky: Bool = true) -> some View {
        containerValue(\.stickyFooter, isSticky)
    }
}
