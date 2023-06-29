//
//  StanfordMemorizeApp.swift
//  StanfordMemorize
//
//  Created by Fellipe Ricciardi Chiarello on 5/9/23.
//

import SwiftUI

@main
struct StanfordMemorizeApp: App {
    private let game = MemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
