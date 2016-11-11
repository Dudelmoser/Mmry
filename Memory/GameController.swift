//
//  GameController.swift
//  Memory
//
//  Created by Jan Kleiss on 11/10/16.
//  Copyright © 2016 newmeta. All rights reserved.
//

import Foundation
import UIKit

class GameController {
    
    private let model:Game
    
    init(_ model:Game) {
        self.model = model
    }
    
    func onFlip(button:UIButton) {
        model.flip(button.tag)
    }
    
    func onReset() {
        model.restart()
    }
}
