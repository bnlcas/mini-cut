import Foundation
import SpriteKit

/// A simple UI control that lets the user select a numeric value from a range.
final class Slider<Value>: SKNode, SKInputHandler
    where Value: Translatable & Scalable & Comparable & Isomorphic,
          Value == Value.Offset,
          Value == Value.Factor,
          Value == Value.Isomorphism.Input,
          Value.Isomorphism.Output == CGFloat {
    private var width: CGFloat!
    private var knob: SKShapeNode!
    
    private var knobInactiveBgColor: Color!
    private var knobActiveBgColor: Color!
    private var action: ((Value) -> Void)?
    
    private var toViewX: AnyBijection<Value, CGFloat>!
    
    override var isUserInteractionEnabled: Bool {
        get { true }
        set { /* ignore */ }
    }
    
    init(
        value: Value,
        range: Range<Value>,
        width: CGFloat,
        trackThickness: CGFloat = ViewDefaults.sliderTrackThickness,
        trackBgColor: Color = ViewDefaults.inactiveBgColor,
        knobRadius: CGFloat = ViewDefaults.sliderKnobRadius,
        knobInactiveBgColor: Color = ViewDefaults.knobInactiveBgColor,
        knobActiveBgColor: Color = ViewDefaults.knobActiveBgColor,
        sliderKnobRadius
        action: ((Value) -> Void)? = nil
    ) {
        super.init()
        self.width = width
        self.knobInactiveBgColor = knobInactiveBgColor
        self.knobActiveBgColor = knobActiveBgColor
        self.action = action
        
        toViewX = InverseTranslation(offset: range.lowerBound)
            .then(InverseScaling(divisor: range.upperBound - range.lowerBound))
            .then(Value.isomorphism)
            .then(Scaling(factor: width))
            .then(InverseTranslation(offset: width / 2))
            .erase()
        
        let track = SKSpriteNode(color: trackBgColor, size: CGSize(width: width, height: trackThickness))
        addChild(track)
        
        knob = SKShapeNode(circleOfRadius: knobRadius)
        knob.position = CGPoint(x: toViewX.apply(value), y: 0)
        knob.lineWidth = 0
        knob.fillColor = knobInactiveBgColor
        addChild(knob)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        nil
    }
    
    public func inputDown(at point: CGPoint) {
        knob.fillColor = knobActiveBgColor
    }
    
    public func inputDragged(to point: CGPoint) {
        let newX = max(min(point.x, width / 2), -(width / 2))
        knob.position = CGPoint(x: newX, y: 0)
        action?(toViewX.inverseApply(newX))
    }
    
    public func inputUp(at point: CGPoint) {
        inputDragged(to: point)
        knob.fillColor = knobInactiveBgColor
    }
}
