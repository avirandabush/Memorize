//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Aviran Dabush on 27/05/2025.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(for items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = scaleForSize(count: CGFloat(items.count),
                                            size: geometry.size,
                                            aspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio ,contentMode: .fit)
                }
            }
        }
    }
    
    func scaleForSize(count: CGFloat, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1.0
        
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = ceil(count / columnCount)
            
            if rowCount * height < size.height {
                return floor(size.width / columnCount)
            }
            columnCount += 1
        } while columnCount < count
        
        return floor(min(size.width / count, size.height * aspectRatio))
    }
}
