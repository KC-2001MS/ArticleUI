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
                    Text("Press the plus button and fill in the word registration screen. You can also register words via the Shortcut App.")
#if os(iOS)
                    ShortcutsLink()
#endif
                } header: {
                    Text("Registering words")
                }
                
                Section {
                    Text("You can hide words by pressing the button with the eye icon.The list of hidden words can be displayed with biometric identification.")
                } header: {
                    Text("Hide words")
                }
                
                Section {
                    Text("You can prioritize words by setting an importance level for each word.")
                } header: {
                    Text("Set priority level")
                }
                
                Section {
                    Text("By adding a word to your favorites, you can add the word to your favorites list. You can also prevent words from being deleted.")
                } header: {
                    Text("Favorite")
                }
                
                Section {
                    
                    Text("If you find any problems with this application, please report them via this URL or email.")
#if !os(watchOS) && !os(tvOS)
                    Link("Bug Report Page", destination: URL(string: NSLocalizedString("Bug Report URL", comment: "Bug Report Page")) ?? URL(string: NSLocalizedString("https://kc-2001ms.github.io/en/", comment: "Iroiro's Top Page"))!)
#endif
                } header: {
                    Text("Report bugs")
                }
                
                Section {
                    Text("You can review the privacy policy for this application at the following site")
                    
#if !os(watchOS) && !os(tvOS)
                    Link("Privacy Policy Page", destination: URL(string: NSLocalizedString("https://kc-2001ms.github.io/en/privacy.html", comment: "Iroiro's Top Page")) ?? URL(string: NSLocalizedString("https://kc-2001ms.github.io/en/", comment: "Iroiro's Top Page"))!)
#else
                    Text(verbatim:"https://kc-2001ms.github.io/")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
#endif
                } header: {
                    Text("Privacy Policy")
                }
            }
            .navigationTitle("Help")
        }
    }
}

#Preview {
    ContentView()
}
