//
//  ContentView.swift
//  Sample
//  
//  Created by Keisuke Chinone on 2024/10/01.
//


import SwiftUI
import ArticleUI

enum NoteID { case layout, watchOS }

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Article {
                Section {
                    Text(
                        "Welcome to ArticleUI. This package allows you to easily create views consisting of multiple headings and content like articles."
                    )
                } header: {
                    Text("What is ArticleUI")
                    Text("Create easily organized article UI")
                }

                Section {
                    Text(AttributedString(localized: "Easily create a scrollable article UI[*](\(URL(annotation: NoteID.layout).absoluteString)); using Article and Section views, you can easily create views that include headings and content."))
                } header: {
                    Text("Build easily scrollable views")
                }

                Section {
                    Text(AttributedString(localized: "This package supports many iOS as well as macOS, visionOS and watchOS[*](\(URL(annotation: NoteID.watchOS).absoluteString)). tvOS is in the process of scrolling adjustment."))
                } header: {
                    Text("Support for many platforms")
                }

                Section {
                    Text(
                        "This package can be found in the repository at the following URL"
                    )

                    Link(
                        "ArticleUI",
                        destination: URL(
                            string: "https://github.com/KC-2001MS/ArticleUI"
                        )!
                    )
                } header: {
                    Text("GitHub")
                }

#if !os(tvOS) && !os(watchOS)
                Section {
                    AppCard(
                        name: "Japan Corp Info",
                        subtitle: "Manage Japan corporation info",
                        iconName: "Japan Corp Info",
                        appID: "id6477782786"
                    ) {
                        Text(
                            """
The Japan Corp Info App is the best way to easily manage your Japan corporation information.
The app allows you to easily search gBizINFO data provided by METI, a ministry of the Japanese government.
The searched data can be saved in the device and can be viewed offline. You can also add memos and tags to each company, which can be used for corporate analysis.
"""
                        )
                    }
                } header: {
                    Text("Using this package")
                }
                .articleRowSeparator(true)
#endif

                Section {
                    HStack(alignment: .top) {
                        LabeledContent {
                            VStack(alignment: .trailing) {
                                Link(
                                    "GitHub",
                                    destination: URL(
                                        string: "https://github.com/KC-2001MS"
                                    )!
                                )
                                Link(
                                    "Mail",
                                    destination: URL(
                                        string: "mailto:iroiro.work1234@gmail.com"
                                    )!
                                )
                                Link(
                                    "X",
                                    destination: URL(
                                        string: "https://twitter.com/IroIro1234work"
                                    )!
                                )
                                Link(
                                    "Mastodon",
                                    destination: URL(
                                        string: "https://mastodon.social/@Iroiro"
                                    )!
                                )
                                Link(
                                    "Bluesky",
                                    destination: URL(
                                        string: "https://bsky.app/profile/bluesky.iroiro.me"
                                    )!
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        } label: {
                            Text("Keisuke Chinone")
                                .bold()
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                } header: {
                    Text("Author")
                } footer: {
                    Text(
                        "Information about the author who manages this repository."
                    )
                }
            } annotation: {
                AnnotationItem(NoteID.layout, "Article and Section views automatically handle layout and styling.")
                AnnotationItem(NoteID.watchOS, "watchOS support requires watchOS 11 or later.")
            }
            .articleStyle(.grouped)
            .navigationTitle("Wellcome to ArticleUI")
        }
    }
}

#Preview {
    ContentView()
}
