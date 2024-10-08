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
    private var tint: Color?
    
    @ViewBuilder private var content: Content
    
    internal init(
        tint: Color? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.tint = tint
        self.content = content()
    }
    
    var body: some View {
            VStack(alignment: .leading,spacing: 5) {
                content
            }
#if !os(watchOS) && !os(tvOS)
            .font(.title)
#else
            .font(.headline)
#endif
            .bold()
#if !os(visionOS)
            .foregroundStyle(tint ?? Color.accentColor)
#endif
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
    @ViewBuilder private  var content: Content
    
    internal init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    internal var body: some View {
        VStack(alignment: .trailing,spacing: 5) {
            content
        }
        .font(.caption2)
        .foregroundStyle(Color.secondary)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview("Header",traits: .sizeThatFitsLayout) {
    SectionHeaderView {
        Text("Header")
    }
}

#Preview("Footer",traits: .sizeThatFitsLayout) {
    SectionFooterView {
        Text("Footer")
    }
}
