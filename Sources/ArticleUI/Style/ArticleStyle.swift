//
//  ArticleStyle.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/08.
//

import SwiftUI

/// A protocol that describes the appearance of an article.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public protocol ArticleStyle {
    /// The properties of an article section.
    typealias Configuration = ArticleStyleConfiguration
    
    /// A view that represents the body of an article section.
    associatedtype Body: View
    
    /// Creates a view that represents the body of the article sections.
    /// - Parameter configuration: The properties of an article section.
    /// - Returns: View of an article section with adapted styles
    ///
    /// The system calls this method for each article sections in a view hierarchy where this style is the current article style.
    func makeBody(configuration: Configuration) -> Body
}

/// The properties of an article section.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct ArticleStyleConfiguration {
    /// A type-erased label of an article section.
    struct Label: View {
        init<Content: View>(@ViewBuilder _ content: () -> Content) {
        body = AnyView(content())
      }

      var body: AnyView
    }
    
    /// A view that describes a View in an Article Section
    let label: ArticleStyleConfiguration.Label
    
    /// ContainerValues in an Article Section
    let containerValues:  ContainerValues
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension ArticleStyle where Self == DefaultArticleStyle {
    /// The default article style, based on the article’s context.
    public static var automatic: DefaultArticleStyle {
        get {
            DefaultArticleStyle()
        }
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension ArticleStyle where Self == PlainArticleStyle {
    /// A article style that doesn’t style or decorate its content
    public static var plain: PlainArticleStyle {
        get {
            PlainArticleStyle()
        }
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension ArticleStyle where Self == GroupedArticleStyle {
    public static var grouped: GroupedArticleStyle {
        get {
            GroupedArticleStyle()
        }
    }
}

/// The default article style, based on the article’s context.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct DefaultArticleStyle: ArticleStyle {
    public func makeBody(configuration: Configuration) -> some View {
   #if os(visionOS)
        return GroupedArticleStyle().makeBody(configuration: configuration)
   #else
        return PlainArticleStyle().makeBody(configuration: configuration)
   #endif
    }
}

/// A article style that doesn’t style or decorate its content
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct PlainArticleStyle: ArticleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(configuration.containerValues.articleRowInsets ?? EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
public struct GroupedArticleStyle: ArticleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(configuration.containerValues.articleRowInsets ?? EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
            .padding(.horizontal)
            .background {
                    RoundedRectangle(cornerRadius: 25)
#if os(macOS)
                    .fill(Color.secondary.opacity(0.2))
                #else
                        .fill(.regularMaterial)
                #endif
            }
    }
}
