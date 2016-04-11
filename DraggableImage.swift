import Foundation
import UIKit

class DraggableImage: UIImageView {

    let USER_INTERACTION_ENABLED = true

    var originalPosition: CGPoint!
    var dropTarget: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = USER_INTERACTION_ENABLED
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.userInteractionEnabled = USER_INTERACTION_ENABLED
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.center = originalPosition
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)

            if CGRectContainsPoint(target.frame, position) {
                let notification = NSNotification(name: "onTargetDropped", object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            }
        }
    }
}
