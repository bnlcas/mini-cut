import Foundation
import SpriteKit

/// A visual representation of a track's controls.
final class TrackClipView: SKSpriteNode {
    convenience init(state: MiniCutState, trackId: UUID, id: UUID, height: CGFloat, toViewScale: AnyBijection<TimeInterval, CGFloat>) {
        // TODO: Subscribe to listeners
        guard let clip = state.timeline[trackId]?[id] else {
            fatalError("Could not find track with id \(trackId)")
        }
        
        self.init(color: clip.clip.content.color, size: CGSize(width: toViewScale.apply(clip.clip.length), height: height))
        
        let thumb = generateThumbnail(from: clip.clip, size: ViewDefaults.thumbnailSize)
        addChild(thumb)
    }
}
