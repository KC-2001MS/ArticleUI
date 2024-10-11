// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// Container that displays headings and content as if it were an article
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct Article<Content: View, Style: ArticleStyle>: View {
    var style: Style
    @ViewBuilder var content: Content
    
    /// Creates an article with the given content.
    /// - Parameter content: The content of the article
    public init(
        @ViewBuilder content: () -> Content
    ) where Style == DefaultArticleStyle {
        self.style = DefaultArticleStyle()
        self.content = content()
    }
    
    /// Initializer used with the articleStyle modifier
    private init(
        style: Style,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = content()
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 0) {
                Group(sections: content) { sections in
                    ForEach(
                        Array(sections.enumerated()),
                        id: \.element.id
                    ) {
 sectionsIndex,
 section in
                        let sectionValues = section.containerValues
                        VStack(alignment: .leading,spacing: 10) {
                            
                            if !section.header.isEmpty {
                                SectionHeaderView(
                                    tint: sectionValues.articleSectionHeaderTint
                                ) {
                                    section.header
                                }
#if os(tvOS)
                                .focusEffectDisabled()
                                .focusable()
#endif
                            }
                            
                            style.makeBody(
                                configuration: .init(
                                    label: .init(
{
    VStack(
        alignment: .leading,
        spacing: (sectionValues.articleRowSpacing ?? 10) / 2
    ) {
        ForEach(
            Array(section.content.enumerated()),
            id: \.element.id
        ) {
 subviewIndex,
 subview in
            let rowValues = subview.containerValues
            subview
                .tint(
                    rowValues.articleItemTint ?? sectionValues.articleItemTint ?? .accentColor
                )
#if os(tvOS)
                .focusEffectDisabled()
                .focusable()
#endif
            if subviewIndex < section.content.count - 1 && (
                sectionValues.articleRowSeparatorVisibility || rowValues.articleRowSeparatorVisibility
            ) {
                Divider()
                    .background(
                        rowValues.articleRowSeparatorTint ?? sectionValues.articleRowSeparatorTint ?? .secondary
                    )
            }
        }
                                            
        if !section.footer.isEmpty && sectionValues.articleFooterPlacement == .insideContent {
            SectionFooterView {
                section.footer
            }
        }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
}),
                                    containerValues: sectionValues
                                )
                            )
                            
                            
                            if !section.footer.isEmpty && (
                                sectionValues.articleFooterPlacement == .afterContent || sectionValues.articleFooterPlacement == .automatic || !sectionValues.stickyFooter
                            ) {
                                SectionFooterView {
                                    section.footer
                                }
#if os(tvOS)
                                .focusEffectDisabled()
                                .focusable()
#endif
                            }
                        }
                        .padding(
                            .bottom,
                            sectionsIndex < sections.count - 1 ?  (
                                sectionValues.articleSectionSpacing ?? 20
                            ) : 0
                        )
                    }
                    
                    let filteredSection = sections.filter(
                        { return ($0.containerValues.articleFooterPlacement == .annotation || $0.containerValues.stickyFooter) && !(
                            $0.footer.isEmpty
                        )
                        })
                    
                    if !filteredSection.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(
                                    Array(filteredSection.enumerated()),
                                    id: \.element.id
                                ) {
 sectionsIndex,
 section in
                                    if !section.footer.isEmpty && section.containerValues.stickyFooter {
                                        HStack(alignment: .top) {
                                            Text("\(sectionsIndex + 1). ")
                                            section.footer
                                        }
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )
                                        .font(.caption)
                                        .foregroundStyle(Color.secondary)
                                    }
                                }
                            }
                        }
                        .padding(.top ,20)
                    }
                }
            }
#if os(visionOS)
            .padding(25)
#elseif os(watchOS)
            .padding(15)
#else
            .padding(20)
#endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
#if os(iOS)
        .background(Color(uiColor: .secondarySystemBackground))
#endif
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension Article {
    /// Creates an instance that uniquely identifies and creates map content across updates based on the identity of the underlying data.
    /// - Parameters:
    ///   - data: The data that the ``Article`` instance uses to create map content dynamically.
    ///   - content: The map content builder that creates map content dynamically.
    public init<Data: RandomAccessCollection, C: View>(
        _ data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> C
    ) where Data.Element: Identifiable,
    Content == ForEach<Data, Data.Element.ID, C>, Style == DefaultArticleStyle {
        self.init {
            ForEach(data, content: content)
        }
    }
    
    /// Creates an instance that uniquely identifies and creates map content across updates based on the provided key path to the underlying data’s identifier.
    /// - Parameters:
    ///   - data: The data that the ``Article`` instance uses to create map content dynamically.
    ///   - id: The key path to the provided data’s identifier.
    ///   - rowContent: The map content builder that creates map content dynamically.
    ///
    ///   It’s important that the id of a data element doesn’t change, unless the data element has been replaced with a new data element that has a new identity.
    public init<Data, ID, RowContent>(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
    ) where Content == ForEach<Data, ID, RowContent>, Data : RandomAccessCollection, ID : Hashable, RowContent : View, Style == DefaultArticleStyle  {
        self.init {
            ForEach(data, id: id, content: rowContent)
        }
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension Article {
    /// Sets the style for articles within this view to an article style with a custom appearance.
    /// - Parameter style: Adapted ArticleStyle
    /// - Returns: View with adapted style
    public func articleStyle<S>(_ style: S) -> some View where S: ArticleStyle {
        return Article<Content, S>(style: style) {
            self.content
        }
    }
}

#Preview("Static Content") {
    NavigationStack {
        Article {
            Text(String(repeating: "Content 1 ", count: 10))
            
            Section {
                Text(String(repeating: "Content 2 ", count: 20))
                
                Text(String(repeating: "Content 2 ", count: 20))
                    .articleRowSeparatorTint(.accentColor)
                
                Text(String(repeating: "Content 2 ", count: 20))
            } header: {
                Label("Header", systemImage: "2.circle")
            } footer: {
                Text(String(repeating: "Footer 2 ", count: 10))
            }
            .articleRowSpacing(30)
            
            Section("Header 3") {
                Text(String(repeating: "Content 3 ", count: 30))
            }
        }
        .navigationTitle("Static Content")
    }
}

#Preview("Data-Driven Content") {
    let texts = ["Apple", "Yuzu", "Banana"]
    
    NavigationStack {
        Article(texts, id: \.self) { text in
            Text(text)
        }
        .navigationTitle("Static Content")
    }
}
