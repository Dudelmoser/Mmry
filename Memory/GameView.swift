//
//  View.swift
//  Memory
//
//  Created by Jan Kleiss on 11/10/16.
//  Copyright © 2016 newmeta. All rights reserved.
//

import Foundation
import UIKit

class GameView {
    let INNER_MARGIN:Double = 10
    let MARGIN_LEFT:Double = 10
    let MARGIN_RIGHT:Double = 10
    let MARGIN_TOP:Double = 20
    let MARGIN_BOTTOM:Double = 40
    
    let BG_COLOR = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    let CARD_BACK = UIColor.init(red: 40/255.0, green: 45/255.0, blue: 50/255.0, alpha: 1.0)
    let CARD_FRONT = UIColor.init(red: 180/255.0, green: 185/255.0, blue: 190/255.0, alpha: 1.0)
    let CARD_RIGHT = UIColor.init(red: 120/255.0, green: 255/255.0, blue: 60/255.0, alpha: 1.0)
    let CARD_WRONG = UIColor.init(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
    
    private let view:UIView
    private let moves:UILabel
    private var btns:[UIButton] = []
    private var controller:GameController?
    
    let moveLabel = "Moves: "
    
    init(_ view:UIView) {
        self.view = view
        
        moves = UILabel()
        moves.text = moveLabel + "0"
        moves.frame = CGRect(x: MARGIN_LEFT, y: Double(view.frame.height) - MARGIN_BOTTOM,
                             width: 200, height: MARGIN_BOTTOM)
        moves.textColor = CARD_BACK
        view.addSubview(moves)
    }
    
    func update(_ model:Game) {
        moves.text = moveLabel + "\(model.moves)"
        
        for i in 0..<model.cards.count {
            switch(model.cards[i].status) {
            case .facedown:
                btns[i].backgroundColor = CARD_BACK
            case .faceup:
                btns[i].backgroundColor = CARD_FRONT
            case .removed:
                btns[i].backgroundColor = BG_COLOR
                btns[i].setTitleColor(BG_COLOR, for: .normal)
            case .wrong:
                btns[i].backgroundColor = CARD_WRONG
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    model.cards[i].status = .facedown
                    self.btns[i].backgroundColor = self.CARD_BACK
                }
            case .right:
                btns[i].backgroundColor = CARD_RIGHT
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    
                    // dirty workaround to prevent null pointer
                    if (model.moves > 0) {
                        model.cards[i].status = .removed
                        self.btns[i].backgroundColor = self.BG_COLOR
                        self.btns[i].setTitleColor(self.BG_COLOR, for: .normal)
                    }
                }
            }
        }
        
        if model.left == 0 {
            for btn in btns {
                btn.removeFromSuperview()
            }
            btns.removeAll()
            model.restart()
            return
        }
    }
    
    func create(_ model:Game) {
        view.backgroundColor = BG_COLOR
        
        let viewWidth = Double(view.frame.width) - MARGIN_LEFT - MARGIN_RIGHT
        let viewHeight = Double(view.frame.height) - MARGIN_TOP - MARGIN_BOTTOM
        let cardWidth = (viewWidth - Double(model.cols - 1) * INNER_MARGIN) / Double(model.cols)
        let cardHeight = (viewHeight - Double(model.rows - 1) * INNER_MARGIN) / Double(model.rows)
                
        for x in 0..<model.cols {
            for y in 0..<model.rows {
                let btn = UIButton(type: .roundedRect)
                
                let posX = MARGIN_LEFT + Double(x) * INNER_MARGIN + cardWidth * Double(x)
                let posY = MARGIN_TOP + Double(y) * INNER_MARGIN + cardHeight * Double(y)
                btn.frame = CGRect(x: posX, y: posY, width: cardWidth, height: cardHeight)
                
                btn.tag = x * model.rows + y
                btn.setTitle(model.cards[btn.tag].value, for: .normal)
                btn.setTitleColor(CARD_BACK, for: .normal)
                btn.titleLabel!.lineBreakMode = NSLineBreakMode.byCharWrapping
                btn.titleLabel!.textAlignment = NSTextAlignment.center
                btn.titleLabel!.font = UIFont.systemFont(ofSize: 20)
                btn.backgroundColor = CARD_BACK
                view.addSubview(btn)
                btns.append(btn)
            }
        }
        
        if (controller != nil) {
            addController(controller!)
        }
    }
    
    func addController(_ controller:GameController) {
        self.controller = controller
        for btn in btns {
            btn.addTarget(self, action: #selector(onButtonClicked(button:)), for: .touchUpInside)
        }
    }
    
    // WHY NEEDED?
    @objc func onButtonClicked(button:UIButton) {
        controller?.onFlip(button: button)
    }
}
