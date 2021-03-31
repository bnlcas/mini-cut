//: A tiny video editor

import PlaygroundSupport
import SpriteKit

let width = 900
let height = 700

// Create and initialize the scene
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: width, height: height))
let scene = MiniCutScene(size: CGSize(width: width, height: height))

scene.scaleMode = .aspectFill
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
