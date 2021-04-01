import Foundation
import SpriteKit

/// A view of the user's clip library.
final class LibraryView: SKSpriteNode {
    private var librarySubscription: Subscription!
    
    convenience init(state: MiniCutState, size: CGSize) {
        self.init(color: ViewDefaults.quaternary, size: size)
        
        librarySubscription = state.libraryWillChange.subscribeFiring(state.library) { [unowned self] in
            let header = Label("Library", fontSize: ViewDefaults.headerFontSize, fontColor: ViewDefaults.secondary)
            let clips = Flow(size: CGSize(width: size.width, height: size.height - header.calculateAccumulatedFrame().height - ViewDefaults.padding))
            clips.removeAllChildren()
            
            for clip in $0.clips {
                clips.addChild(LibraryClipView(clip: clip))
            }
            
            let stack = Stack.vertical(anchored: true, [header])
            stack.position = CGPoint(x: 0, y: (size.height / 2) - ViewDefaults.padding - (stack.calculateAccumulatedFrame().height / 2))
            stack.addChild(clips)
            
            removeAllChildren()
            addChild(stack)
        }
    }
}
