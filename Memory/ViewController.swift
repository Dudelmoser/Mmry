//
//  ViewController.swift
//  Memory
//
//  Created by Jan Kleiss on 10/26/16.
//  Copyright © 2016 newmeta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastCard:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gameView = GameView(view)
        let game = Game(gameView)
        let controller = GameController(game)
        gameView.addController(controller)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
