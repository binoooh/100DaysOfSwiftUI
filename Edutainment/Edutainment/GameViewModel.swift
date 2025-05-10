//
//  GameViewModel.swift
//  Edutainment
//
//  Created by @binoooh on 5/7/25.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    var selectedGameLevel: GameData? {
        didSet {
            isShowingGameView = true
        }
    }
    @Published var isShowingGameView = false
}
