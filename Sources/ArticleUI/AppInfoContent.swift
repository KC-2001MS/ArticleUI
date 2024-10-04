//
//  AppInfo.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

import SwiftUI

#if !os(tvOS)
@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
public struct AppInfoContent<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let app: AppInfo
    
    var content: Content
    
    
    public init(app: AppInfo, @ViewBuilder content: () -> Content) {
        self.app = app
        self.content = content()
    }
    
    public var body: some View {
        if dynamicTypeSize > .large || horizontalSizeClass == .compact {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    //                    Image(appInfo.imageName, bundle: .module)
                    Image(app.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    
                    Spacer()
                    
                    Text(app.name)
                        .bold()
                }
                .frame(maxWidth: .infinity,alignment: .center)
                
                VStack(alignment: .trailing, spacing: 10) {
                    content
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    Link(
                        destination: URL(
                            string: "https://apps.apple.com/app/\(app.id)"
                        )!
                    ){
                        Image("Download", bundle: .module)
                        //                        Image("Download")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .center) {
                    //                    Image(appInfo.imageName, bundle: .module)
                    Image(app.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(.vertical, 10)
                    
                    Text(app.name)
                }
                .frame(width: 175)
                .frame(maxHeight: .infinity, alignment: .center)
                
                
                VStack(alignment: .trailing, spacing: 10) {
                    content
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    Link(
                        destination: URL(
                            string: "https://apps.apple.com/app/\(app.id)"
                        )!
                    ){
                        Image("Download", bundle: .module)
                        //                        Image("Download")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}


//#Preview(traits: .sizeThatFitsLayout) {
//    let info: AppInfo = .init(
//        name: "Sample",
//        imageName: "Sample",
//        id: "id1612026794"
//    )
//    
//    AppInfoContent(appInfo: info) {
//        Text("Simple Editor X Contents")
//            .multilineTextAlignment(.leading)
//            .font(.callout)
//            .foregroundStyle(.secondary)
//    }
//}
#endif
