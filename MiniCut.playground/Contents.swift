//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

let width = 800
let height = 500

// Create and initialize the scene
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: width, height: height))
let scene = MiniCutScene(size: CGSize(width: width, height: height))
scene.scaleMode = .aspectFill
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
