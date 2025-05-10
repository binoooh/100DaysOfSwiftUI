//
//  Question.swift
//  Edutainment
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let number1: Int
    let number2: Int
    var correctAnswer: Int { number1 * number2 }
}
