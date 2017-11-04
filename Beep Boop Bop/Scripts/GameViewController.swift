//
//  GameViewController.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! SKView
        let scene = CircleScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .black
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
