//
//  Card.swift
//  Memory
//
//  Created by Jan Kleiss on 11/10/16.
//  Copyright © 2016 newmeta. All rights reserved.
//

import Foundation

enum CardStatus {
    case facedown, faceup, right, wrong, removed
}

class Card {
    static let SUITS = ["♤","♡","♢","♧"]
    static let RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "B", "D", "K"]
    
    private(set) static var deck:[String] = []
    private(set) static var current = -1
    
    let value: String
    var status: CardStatus = .facedown
    
    init() {
        // if more cards are requested than existant
        if (Card.current >= Card.deck.count - 1) {
            Card.current = -1
        }
        Card.current += 1
        value = Card.deck[Card.current]
    }
    
    static func initDeck(_ n:Int) {
        if (n < 1 || n > 32) {
            return
        }
        deck = getRandomPairs(n)
    }
    
    static func getFullDeck() -> [String] {
        var deck:[String] = []
        for suit in SUITS {
            for rank in RANKS {
                deck.append(suit + "\n" + rank)
            }
        }
        return deck
    }
    
    static func getRandomCard(_ deck:inout[String]) -> String {
        let index = Int(arc4random_uniform(UInt32(deck.count)))
        let card = deck[index]
        deck.remove(at: index)
        return card
    }
    
    static func getRandomCards(_ n:Int) -> [String]{
        var cards:[String] = []
        var deck = getFullDeck()
        for _ in 0..<n {
            cards.append(getRandomCard(&deck))
        }
        return cards
    }
    
    static func getRandomPairs(_ n:Int) -> [String] {
        var cards = getRandomCards(n)
        cards.append(contentsOf: cards)
        var shuffled:[String] = []
        for _ in 0..<cards.count {
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards[index])
            cards.remove(at:index)
        }
        return shuffled
    }
}
