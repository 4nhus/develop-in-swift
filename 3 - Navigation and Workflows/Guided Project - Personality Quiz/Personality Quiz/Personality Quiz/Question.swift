//
//  Question.swift
//  Personality Quiz
//
//  Created by Anh Nguyen on 25/12/2024.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: EmojiType
}

enum EmojiType: Character {
    case willy = "🍆", wet = "💦", gyat = "🍑", devil = "😈"
    
    var definition: String {
        switch self {
        case .willy:
            "You’ve got big energy and aren’t afraid to let it show. Always bringing the heat, you’re the type to slide into a convo and leave everyone blushing."
        case .wet:
            "Dripping with charisma, you’ve got everyone’s attention when you walk in the room. Whether it’s vibes or thirst traps, you’re all about keeping things… well, moist."
        case .gyat:
            "You’re packing all the right assets, and you know how to make them work. People can’t help but stare, and let’s be real, you don’t mind soaking up the admiration."
        case .devil:
            "You’re downright dirty—minded, that is. Always up to no good with that wicked little smirk, you love teasing just enough to get hearts racing and minds wandering."
        }
    }
}
