//
//  Model.swift
//  Memory
//
//  Created by Jan Kleiss on 11/10/16.
//  Copyright © 2016 newmeta. All rights reserved.
//

class Game {
    
    var cols = 1
    var rows = 1
    
    private(set) var left = 0
    private(set) var moves = 0
    private(set) var lastCard:Card?
    private(set) var cards:[Card] = []
    
    private let view:GameView
    
    init(_ view:GameView) {
        self.view = view
        restart()
    }
    
    func restart() {
        cols += 1
        rows += 1
        moves = 0
        left = cols * rows / 2
        cards.removeAll()
        Card.initDeck(left)
        for _ in 0..<cols * rows {
            cards.append(Card())
        }
        view.create(self)
    }
    
    func flip(_ index:Int) {
        let curCard = cards[index]
        if (curCard.status == .faceup || curCard.status == .right || curCard.status == .removed) {
            return
        } else {
            curCard.status = .faceup
        }
        
        if (lastCard != nil) {
            if (curCard.value == lastCard?.value) {
                curCard.status = .right
                lastCard?.status = .right
                left -= 1
            } else {
                curCard.status = .wrong
                lastCard?.status = .wrong
            }
            lastCard = nil
            moves += 1
        } else {
            lastCard = curCard
        }
        view.update(self)
    }
}
