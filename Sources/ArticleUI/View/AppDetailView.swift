//
//  AppDetailView.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import SwiftUI

#if !os(tvOS) && !os(watchOS)
/// Sheet content that presents an enlarged, more readable version of ``AppCard``.
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
internal struct AppDetailView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @ScaledMetric(relativeTo: .largeTitle) private var iconSize: CGFloat = 96

    private var name: LocalizedStringKey

    private var subtitle: LocalizedStringKey

    private var iconSource: AppIconSource

    private var id: String

    private var content: Content

    private var downloadLinkStyle: DownloadLinkStyle

    internal init(
        name: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        iconSource: AppIconSource,
        id: String,
        content: Content,
        downloadLinkStyle: DownloadLinkStyle
    ) {
        self.name = name
        self.subtitle = subtitle
        self.iconSource = iconSource
        self.id = id
        self.content = content
        self.downloadLinkStyle = downloadLinkStyle
    }

    internal var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Group {
                            switch iconSource {
                            case .asset(let assetName, let bundle):
                                Image(assetName, bundle: bundle)
                                    .resizable()
                                    .scaledToFit()
                            case .staticURL(let url):
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            case .adaptiveURL(let light, let dark):
                                AsyncImage(url: colorScheme == .dark ? dark : light) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        Image(systemName: "app.dashed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        .frame(width: iconSize, height: iconSize)
                        .accessibilityHidden(true)

                        Text(name, bundle: .main)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        if subtitle != "" {
                            Text(subtitle, bundle: .main)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }

                    content
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                        .foregroundStyle(.primary)

#if !os(iOS) && !os(visionOS)
                    DownloadLink(
                        id: id,
                        name: name,
                        downloadLinkStyle: downloadLinkStyle
                    )
#endif
                }
                .padding()
            }
            .navigationTitle(Text(name, bundle: .main))
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label {
                            Text("Close", bundle: .module)
                        } icon: {
                            Image(systemName: "xmark")
                        }
                        #if os(macOS)
                        .labelStyle(.titleOnly)
                        #endif
                    }
                    #if os(iOS)
                    .buttonStyle(.borderless)
                    #endif
                }
            }
        }
    }
}
#endif
