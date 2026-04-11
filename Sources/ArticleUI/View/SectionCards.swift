//
//  SectionCard.swift
//  ArticleUI
//
//  Created by Keisuke Chinone on 2024/10/01.
//

import SwiftUI

/// View that builds the header of the Section of the Article.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
internal struct SectionHeaderView<Content: View>: View {
    let containerValues: ContainerValues?
    
    @ViewBuilder private var content: Content
    
    internal init(
        containerValues: ContainerValues? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.containerValues = containerValues
        self.content = content()
    }
    
    private var tintColor: Color {
        containerValues?.articleSectionHeaderTint ?? Color.accentColor
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Group(subviews: content) { subviews in
                if let first = subviews.first {
                    first
#if !os(watchOS) && !os(tvOS)
                        .font(.title)
#else
                        .font(.headline)
#endif
                        .bold()
#if !os(visionOS)
                        .foregroundStyle(tintColor)
#endif
                }

                ForEach(subviews.dropFirst(1)) { subview in
                    subview
#if !os(watchOS) && !os(tvOS)
                        .font(.subheadline)
#else
                        .font(.caption)
#endif
#if !os(visionOS)
                        .foregroundStyle(.secondary)
#endif
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }
}

/// View that builds the footer of the Section of the Article.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
internal struct SectionFooterView<Content: View>: View {
    let containerValues: ContainerValues?
    
    @ViewBuilder private  var content: Content
    
    internal init(
        containerValues: ContainerValues? = nil,
        @ViewBuilder _ content: () -> Content
    ) {
        self.containerValues = containerValues
        self.content = content()
    }
    
    internal var body: some View {
        VStack(alignment: .trailing, spacing: 3) {
            content
        }
        .font(.caption2)
        .foregroundStyle(Color.secondary)
        .frame(
            maxWidth: .infinity,
            alignment: containerValues?.articleSectionType == .default ? .trailing : .leading
        )
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isSummaryElement)
    }
}

#Preview("Header", traits: .sizeThatFitsLayout) {
    SectionHeaderView {
        Text("Header")
    }
}

#Preview("Header with Subtitle", traits: .sizeThatFitsLayout) {
    SectionHeaderView {
        Text("Main Title")
        Text("This is a subtitle")
    }
}

#Preview("Footer",traits: .sizeThatFitsLayout) {
    SectionFooterView {
        Text("Footer")
    }
}
