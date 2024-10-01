//
//  SectionCard.swift
//  ArticleUI
//
//  Created by Keisuke Chinone on 2024/10/01.
//

import SwiftUI

struct SectionHeaderView<Content: View>: View {
    @ViewBuilder var content: Content
    
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
            .foregroundStyle(Color.accentColor)
#endif
    }
}

struct SectionFooterView<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
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
