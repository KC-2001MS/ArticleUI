// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct Article<Content: View>: View {
    @ViewBuilder var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 20) {
                Group(sections: content) { sections in
                    ForEach(sections) { section in
                        VStack(alignment: .leading,spacing: 10) {
                            if !section.header.isEmpty {
                                SectionHeaderView {
                                    section.header
                                }
                            }
                            
                            VStack(alignment: .leading,spacing: 5) {
                                ForEach(section.content) { subview in
                                    subview
                                        
                                }
                                
//                                if !section.footer.isEmpty {
//                                    SectionFooterView {
//                                        section.footer
//                                    }
//                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
#if os(visionOS)
                            .padding(.horizontal)
                            .padding(.vertical, 25)
                            .background(.regularMaterial, in: .rect(cornerRadius: 25))
#endif
                            if !section.footer.isEmpty {
                                SectionFooterView {
                                    section.footer
                                }
                            }
                        }
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

extension Article {
    /// Creates a display board representing the given collection, mapping each
    /// data element to a content view to draw on a card.
    init<Data: RandomAccessCollection, C: View>(
        _ data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> C
    ) where Data.Element: Identifiable,
        Content == ForEach<Data, Data.Element.ID, C> {
        self.init {
            ForEach(data, content: content)
        }
    }
}

#Preview("Static Content") {
    NavigationStack {
        Article {
            Text(String(repeating: "Content 1 ", count: 10))
            
            Section {
                Text(String(repeating: "Content 2 ", count: 20))
            } header: {
                Label("Header", systemImage: "2.circle")
            } footer: {
                Text(String(repeating: "Footer 2 ", count: 10))
            }

            
            Section("Header 3") {
                Text(String(repeating: "Content 3 ", count: 30))
            }
        }
        .navigationTitle("Static Content")
    }
}

//#Preview("Data-Driven Content") {
//    let texts = ["Apple", "Yuzu", "Banana"]
//    NavigationStack {
//        Article(texts, id: \.self) { text in
//            Text(song.title)
//        }
//        .navigationTitle("Static Content")
//    }
//}
