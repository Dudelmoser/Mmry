//
//  ViewController.swift
//  Memory
//
//  Created by Jan Kleiss on 10/26/16.
//  Copyright © 2016 newmeta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    let CARDS_X = 3
    let CARDS_Y = 4
    let INNER_MARGIN:Double = 10
    let MARGIN_LEFT:Double = 10
    let MARGIN_RIGHT:Double = 10
    let MARGIN_TOP:Double = 20
    let MARGIN_BOTTOM:Double = 40
    
    let BG_COLOR = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    let CARD_BACK = UIColor.init(red: 40/255.0, green: 45/255.0, blue: 50/255.0, alpha: 1.0)
    let CARD_FRONT = UIColor.init(red: 180/255.0, green: 185/255.0, blue: 190/255.0, alpha: 1.0)
    let CARD_SUCCESS = UIColor.init(red: 120/255.0, green: 255/255.0, blue: 60/255.0, alpha: 1.0)
    let CARD_FAILURE = UIColor.init(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    
    let SUITS = ["♤","♡","♢","♧"]
    let RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "B", "D", "K"]
    var cards:[String] = []
    var locked = false
    
    var btns:[Int:UIButton] = [:]
    var lastCard:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = BG_COLOR
        
        let viewWidth = Double(view.frame.width) - MARGIN_LEFT - MARGIN_RIGHT
        let viewHeight = Double(view.frame.height) - MARGIN_TOP - MARGIN_BOTTOM
        let cardWidth = (viewWidth - Double(CARDS_X - 1) * INNER_MARGIN) / Double(CARDS_X)
        let cardHeight = (viewHeight - Double(CARDS_Y - 1) * INNER_MARGIN) / Double(CARDS_Y)
        
        for x in 0..<CARDS_X {
            for y in 0..<CARDS_Y {
                let btn = UIButton(type: .RoundedRect)
                let posX = MARGIN_LEFT + Double(x) * INNER_MARGIN + cardWidth * Double(x)
                let posY = MARGIN_TOP + Double(y) * INNER_MARGIN + cardHeight * Double(y)
                
                btn.frame = CGRect(x: posX, y: posY, width: cardWidth, height: cardHeight)
                btn.tag = x * CARDS_Y + y
                btn.setTitle(cards[btn.tag], forState: UIControlState.Normal)
                btn.setTitleColor(CARD_BACK, forState: UIControlState.Normal)
                btn.backgroundColor = CARD_BACK
                btn.addTarget(self, action: "buttonPressed:", forControlEvents: <#T##UIControlEvents#>)
                view.addSubview(btn)
                btns[btn.tag] = btn
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonPressed(btn: UIButton!) {
        if ((lastCard) != nil) {
            if (btn.tag != lastCard.tag) {
                if (btn.currentTitle == lastCard?.currentTitle) {
                    btn.backgroundColor = CARD_SUCCESS
                    lastCard.backgroundColor = CARD_SUCCESS
                    print("Good job!")
                } else {
                    btn.backgroundColor = CARD_FAILURE
                    lastCard.backgroundColor = CARD_FAILURE
                    print("Cards not matching!")
                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                        btn.backgroundColor = self.CARD_BACK
//                        self.lastCard?.backgroundColor = self.CARD_BACK
//                    }
                }
            }
            lastCard = nil
        } else {
            lastCard = btn
            btn.backgroundColor = CARD_FRONT
        }
    }
    
    func getCardDeck() -> [String] {
        var deck:[String] = []
        for suit in SUITS {
            for rank in RANKS {
                deck.append(suit + rank)
            }
        }
        return deck
    }
    
    func getRandomCard(var deck:[String]) -> String {
        let index = Int(arc4random_uniform(UInt32(deck.count)))
        let card = deck[index]
        deck.removeAtIndex(index)
        return card
    }
    
    func getRandomCards(n:Int) -> [String]{
        var cards:[String] = []
        let deck = getCardDeck()
        for _ in 0..<n {
            cards.append(getRandomCard(deck))
        }
        return cards
    }
    
    func getRandomPairs(n:Int) -> [String] {
        var cards = getRandomCards(n)
        cards.appendContentsOf(cards)
        var shuffled:[String] = []
        for _ in 0..<cards.count {
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards)
            
        }
    }
}
