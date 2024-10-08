//
//  ContainerValues.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/08.
//

import SwiftUI

@available(iOS 18, *)
@available(macOS 15, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
@available(tvOS 18, *)
extension ContainerValues {
    @Entry var articleRowInsets: EdgeInsets?
    @Entry var articleItemTint: Color?
    @Entry var articleRowSeparatorVisibility: Bool = false
    @Entry var articleRowSeparatorTint: Color?
    @Entry var articleSectionHeaderTint: Color?
    @Entry var articleRowSpacing: CGFloat?
    @Entry var articleSectionSpacing: CGFloat?
    @Entry var stickyFooter: Bool = false
}
