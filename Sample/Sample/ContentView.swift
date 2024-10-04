//
//  ContentView.swift
//  Sample
//  
//  Created by Keisuke Chinone on 2024/10/01.
//


import SwiftUI
import ArticleUI
import AppIntents

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Article {
                Section {
                    Text("Create easily organized article UI")
                        .foregroundStyle(.gray)
                    Text(
                        "Welcome to ArtcleUI. This package allows you to easily create views consisting of multiple headings and content like articles."
                    )
                } header: {
                    Text("What is ArticleUI")
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(Color.primary)
                }
                
                Section {
                    Text(
                        "Easily create a scrollable article UI; using Article and Section views, you can easily create views that include headings and content."
                    )
                } header: {
                    Text("Build easily scrollable views")
                }
                
                Section {
                    Text(
                        "This package supports many iOS as well as macOS, visionOS and watchOS. tvOS is in the process of scrolling adjustment."
                    )
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
                
                Section {
                    HStack(alignment: .top) {
                        Text("Keisuke Chinone")
                            .bold()
                            .font(.headline)
                        
                        Spacer()
                        
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
                    }
                    .frame(maxWidth: .infinity)
                } header: {
                    Text("Author")
                } footer: {
                    Text(
                        "Information about the author who manages this repository."
                    )
                }
            }
            .navigationTitle("ArticleUI Help")
        }
    }
}

#Preview {
    ContentView()
}
