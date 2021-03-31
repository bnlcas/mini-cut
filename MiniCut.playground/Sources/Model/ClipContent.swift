import Foundation
import AppKit
import AVFoundation

/// Some form of audiovisual content.
enum ClipContent {
    case text(ClipText)
    case video(ClipVideo)
    case audio(ClipAudio)
    case image(ClipImage)
    case color(ClipColor)
    
    struct ClipText {
        var text: String
        var size: CGFloat
        var color: Color
    }
    
    struct ClipVideo {
        var asset: AVAsset
    }
    
    struct ClipAudio {
        var asset: AVAsset
    }
    
    struct ClipImage {
        var image: Image
    }
    
    struct ClipColor {
        var color: Color
    }
    
    var duration: TimeInterval? {
        switch self {
        case .video(let video):
            return video.asset.duration.seconds
        case .audio(let audio):
            return audio.asset.duration.seconds
        default:
            return nil
        }
    }
}
