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
extension View {
    /// Applies an inset to the rows in an article.
    /// - Parameter insets: The EdgeInsets to apply to the edges of the view.
    /// - Returns: A view that uses the given edge insets when used as a article cell.
    public func articleRowInsets(_ insets: EdgeInsets?) -> some View {
        containerValue(\.articleRowInsets, insets)
    }

    /// Sets a fixed tint color for content in an article.
    /// - Parameter tint: The color to use to tint the content. Use nil to avoid overriding the inherited tint.
    /// - Returns: View of the adapted result
    public func articleItemTint(_ tint: Color?) -> some View {
        containerValue(\.articleItemTint, tint)
    }

    /// Sets the display mode for the separator associated with this specific row.
    /// - Parameter visibility: The visibility of this row’s separators.
    /// - Returns: View of the adapted result
    public func articleRowSeparator(_ visibility: Bool = true) -> some View {
        containerValue(\.articleRowSeparatorVisibility, visibility)
    }

    /// Sets the tint color associated with a row.
    /// - Parameter color: The color to use to tint the row separators, or nil to use the default color for the current article style.
    /// - Returns: View of the adapted result
    public func articleRowSeparatorTint(_ color: Color?) -> some View {
        containerValue(\.articleRowSeparatorTint, color)
    }

    /// Sets the tint color associated with a section.
    /// - Parameter color: The color to use to tint the section separators, or nil to use the default color for the current article style.
    /// - Returns: View of the adapted result
    public func articleSectionHeaderTint(_ color: Color?) -> some View {
        containerValue(\.articleSectionHeaderTint, color)
    }

    /// Sets the vertical spacing between two adjacent rows in an Article
    /// - Parameter spacing: The spacing value to use. A value of nil uses the default spacing.
    /// - Returns: View of the adapted result
    public func articleRowSpacing(_ spacing: CGFloat) -> some View {
        containerValue(\.articleRowSpacing, spacing)
    }

    /// Sets the spacing between adjacent sections in a ``Article`` to a custom value.
    /// - Parameter spacing: The amount of spacing to apply.
    /// - Returns: View of the adapted result
    public func articleSectionSpacing(_ spacing: CGFloat) -> some View {
        containerValue(\.articleSectionSpacing, spacing)
    }

    @available(
        *,
        deprecated,
        message: "use `func articleFooterPlacement(placement: ArticleFooterPlacement) -> some View`"
    )
    /// Whether to place the Footer at the bottom
    /// - Parameter isSticky: Boolean value of whether to place
    /// - Returns: View of the adapted result
    public func stickyFooter(_ isSticky: Bool = true) -> some View {
        containerValue(\.stickyFooter, isSticky)
    }

    /// Control the display position of the footer
    /// - Parameter placement: Display position of footer
    /// - Returns: View of the adapted result
    public func articleFooterPlacement(placement: ArticleFooterPlacement) -> some View {
        containerValue(\.articleFooterPlacement, placement)
    }

    /// Specify section roles
    /// - Parameter style: Section Roles
    /// - Returns: View of the adapted result
    @available(*, deprecated, message: "articleSectionType is no longer needed")
    public func articleSectionType(style: SectionType) -> some View {
        containerValue(\.articleSectionType, style)
    }

}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension Text {
    /// Creates a superscript annotation number that can be embedded inline in text.
    @available(*, deprecated, message: "Use AnnotationProxy.link(for:) instead")
    public static func annotation(_ index: Int) -> Text {
        var attributed = AttributedString("\(index)")
        attributed.link = URL(string: "articleui-annotation://\(index)")
        attributed.font = .caption2
        attributed.baselineOffset = 6
        return Text(attributed)
    }
}

#Preview("Modifiers", traits: .sizeThatFitsLayout) {
    Article {
        Section {
            Text("Row with custom tint")
                .articleItemTint(.purple)

            Text("Row with separator")
                .articleRowSeparator(true)
                .articleRowSeparatorTint(.red)

            Text("Row with custom spacing")
        } header: {
            Text("Modifier Examples")
        } footer: {
            Text("This footer is placed inside content.")
        }
        .articleRowSpacing(20)
        .articleSectionSpacing(30)
        .articleSectionHeaderTint(.orange)
        .articleFooterPlacement(placement: .insideContent)
    }
}
