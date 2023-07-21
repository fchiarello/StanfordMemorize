//
//  AspectVGrid.swift
//  StanfordMemorize
//
//  Created by Fellipe Ricciardi Chiarello on 7/13/23.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, aspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptativeGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptativeGridItem (width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var colummCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(colummCount)
            let itemHeight =  itemWidth / aspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            
            colummCount += 1
            rowCount = (itemCount + (colummCount - 1)) / colummCount
        } while colummCount < itemCount
        if colummCount > itemCount {
            colummCount = itemCount
        }
        return floor(size.width / CGFloat(colummCount))
    }
}

