// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// An annotation item for use with ``Article``.
///
/// ```swift
/// enum NoteID { case layout, watchOS }
///
/// Article {
///     Text(AttributedString(localized:
///         "See [here](\(URL(articleAnnotation: NoteID.layout))) for details."))
/// } annotation: {
///     AnnotationItem(NoteID.layout, "Layout is automatic.")
///     AnnotationItem(NoteID.watchOS, "Requires watchOS 11.")
/// }
/// ```
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct AnnotationItem: Identifiable {
    public let id: AnyHashable
    let content: Text

    /// Creates an annotation item with a unique ID and a localized string.
    ///
    /// `String.LocalizationValue` conforms to `ExpressibleByStringLiteral`,
    /// so you can pass a string literal directly and it will be localized.
    public init<ID: Hashable>(_ id: ID, _ label: String.LocalizationValue) {
        self.id = AnyHashable(id)
        self.content = Text(AttributedString(localized: label))
    }

    /// Creates an annotation item with a unique ID and a custom `AttributedString`.
    public init<ID: Hashable>(_ id: ID, attributedString label: AttributedString) {
        self.id = AnyHashable(id)
        self.content = Text(label)
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public extension URL {
    /// Creates a URL that links to an annotation item in an ``Article``.
    ///
    /// Use this in an `AttributedString` to create inline annotation links:
    /// ```swift
    /// var attr = AttributedString(localized: "See [here](\(URL(articleAnnotation: NoteID.layout))) for details.")
    /// Text(attr)
    /// ```
    init<ID: Hashable>(articleAnnotation id: ID) {
        self = URL(string: "articleui-annotation://\(id)")!
    }
}

/// A result builder that constructs a list of ``AnnotationItem`` values.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
@resultBuilder
public struct ArticleAnnotationBuilder {
    public static func buildBlock(_ components: AnnotationItem...) -> [AnnotationItem] {
        components
    }
}

/// Container that displays headings and content as if it were an article
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct Article<Content: View, Style: ArticleStyle>: View {
    var style: Style
    @ViewBuilder var content: Content
    private var annotations: AnyView?
    private var annotationIDs: [String] = []

    /// Creates an article with the given content.
    /// - Parameter content: The content of the article
    public init(
        @ViewBuilder content: () -> Content
    ) where Style == DefaultArticleStyle {
        self.style = DefaultArticleStyle()
        self.content = content()
        self.annotations = nil
    }

    /// Creates an article with the given content and annotations displayed at the bottom.
    @available(*, deprecated, message: "Use init(annotation:content:) instead")
    public init<Annotations: View>(
        @ViewBuilder content: () -> Content,
        @ViewBuilder annotations: () -> Annotations
    ) where Style == DefaultArticleStyle {
        self.style = DefaultArticleStyle()
        self.content = content()
        self.annotations = AnyView(annotations())
    }

    /// Creates an article with annotation items displayed at the bottom.
    ///
    /// Use ``URL/init(articleAnnotation:)`` to create inline annotation links in `AttributedString`.
    ///
    /// ```swift
    /// enum NoteID { case layout, watchOS }
    ///
    /// Article {
    ///     Text(AttributedString(localized:
    ///         "See [here](\(URL(articleAnnotation: NoteID.layout))) for details."))
    /// } annotation: {
    ///     AnnotationItem(.layout, "Layout is automatic.")
    ///     AnnotationItem(.watchOS, "Requires watchOS 11.")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - content: A view builder for the article content.
    ///   - annotation: A builder that provides the annotation items.
    public init(
        @ViewBuilder content: () -> Content,
        @ArticleAnnotationBuilder annotation: () -> [AnnotationItem]
    ) where Style == DefaultArticleStyle {
        let items = annotation()
        self.style = DefaultArticleStyle()
        self.content = content()
        self.annotations = AnyView(
            ForEach(items) { item in
                item.content
            }
        )
        self.annotationIDs = items.map { "\($0.id)" }
    }

    /// Initializer used with the articleStyle modifier
    private init(
        style: Style,
        content: Content,
        annotations: AnyView?
    ) {
        self.style = style
        self.content = content
        self.annotations = annotations
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Group(sections: content) { sections in
                    ForEach(
                        Array(sections.enumerated()),
                        id: \.element.id
                    ) {
                        sectionsIndex,
                        section in
                        let sectionValues = section.containerValues
                        VStack(alignment: .leading, spacing: 0) {

                            if !section.header.isEmpty {
                                SectionHeaderView{
                                    section.header
                                }
                                .padding(.bottom, 15)
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
                                                spacing: (
                                                    sectionValues.articleRowSpacing ?? 10
                                                ) / 2
                                            ) {
                                                ForEach(
                                                    Array(
                                                        section.content
                                                            .enumerated()
                                                    ),
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
                                                            .accessibilityHidden(true)
                                                    }
                                                }
                                            
                                                if !section.footer.isEmpty && sectionValues.articleFooterPlacement == .insideContent && !sectionValues.stickyFooter {
                                                    SectionFooterView(
                                                        containerValues: sectionValues
                                                    ) {
                                                        section.footer
                                                    }
                                                    .padding(.top, 15)
                                                }
                                            }
                                            .frame(
                                                maxWidth: .infinity,
                                                alignment: .leading
                                            )
                                        }
                                    ),
                                    containerValues: sectionValues,
                                    footerIsEmpty: section.footer.isEmpty
                                )
                            )
                            
                            
                            if !section.footer.isEmpty && (
                                sectionValues.articleFooterPlacement == .afterContent || sectionValues.articleFooterPlacement == .automatic) && !sectionValues.stickyFooter
                            {
                                SectionFooterView(
                                    containerValues: sectionValues
                                ) {
                                    section.footer
                                }
                                .padding(.top, 15)
#if os(tvOS)
                                .focusEffectDisabled()
                                .focusable()
#endif
                            }
                        }
                        .accessibilityElement(children: .contain)
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
                                .accessibilityHidden(true)

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
                                        .accessibilityElement(children: .combine)
                                        .accessibilityAddTraits(.isSummaryElement)
                                        .id("annotation-\(sectionsIndex + 1)")
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                }

                if let annotations {
                    annotationsSection(annotations)
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
        .environment(\.openURL, OpenURLAction { url in
            if url.scheme == "articleui-annotation",
               let host = url.host() {
                withAnimation {
                    proxy.scrollTo("annotation-\(host)", anchor: .bottom)
                }
                return .handled
            }
            return .systemAction
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
#if os(iOS)
        .background(Color(uiColor: .secondarySystemBackground))
#endif
        } // ScrollViewReader
    }

    private func annotationsSection(_ annotationsView: AnyView) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Divider()
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 5) {
                Group(subviews: annotationsView) { subviews in
                    ForEach(Array(subviews.enumerated()), id: \.element.id) { index, subview in
                        let idString = index < annotationIDs.count ? annotationIDs[index] : "\(index + 1)"
                        HStack(alignment: .top) {
                            Text("\(index + 1). ")
                            subview
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isSummaryElement)
                        .id("annotation-\(idString)")
                    }
                }
            }
        }
        .padding(.top, 20)
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
        return Article<Content, S>(
            style: style,
            content: self.content,
            annotations: self.annotations
        )
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
            .articleFooterPlacement(placement: .insideContent)
            .articleRowSpacing(30)
            
            Section("Header 3") {
                Text(String(repeating: "Content 3 ", count: 30))
            }
        }
        .articleStyle(.grouped)
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
