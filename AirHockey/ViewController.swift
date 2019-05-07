import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    
    @IBOutlet weak var topGoal: UIView!
    @IBOutlet weak var bottomGoal: UIView!
    
    @IBOutlet weak var topPaddle: UIView!
    @IBOutlet weak var bottomPaddle: UIView!
    
    @IBOutlet weak var pack: UIView!
    @IBOutlet weak var centerLine: UIView!
    
    @IBOutlet weak var topHalf: UIView!
    @IBOutlet weak var bottomHalf: UIView!
    
    var topSnapBehavior: UISnapBehavior?
    var bottomSnapBehavior: UISnapBehavior?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        let collision = UICollisionBehavior(items: [pack, topPaddle, bottomPaddle])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        self.view.bringSubviewToFront(pack)
    }
    
    
    @IBAction func topHalfPanGesture(_ sender: UIPanGestureRecognizer) {
        
        if topSnapBehavior != nil {
            animator.removeBehavior(topSnapBehavior!)
        }
        
        switch sender.state {
        case .began, .changed:
            topSnapBehavior = UISnapBehavior(item: topPaddle, snapTo: sender.location(in: self.view))
            
            if pack.frame.intersects(bottomGoal.frame) {
                print("bottom goal")
                
            } else if pack.frame.intersects(topGoal.frame) {
                print("top goal")
            }
            
            animator.addBehavior(topSnapBehavior!)
        default: break
        }
        
    }
    
    
    @IBAction func bottomHalfPanGesture(_ sender: UIPanGestureRecognizer) {
        
        if bottomSnapBehavior != nil {
            animator.removeBehavior(bottomSnapBehavior!)
        }
        
        switch sender.state {
        case .began, .changed:
            bottomSnapBehavior = UISnapBehavior(item: bottomPaddle, snapTo: sender.location(in: self.view))
            animator.addBehavior(bottomSnapBehavior!)
            
            if pack.frame.intersects(bottomGoal.frame) {
                print("bottom goal")
            } else if pack.frame.intersects(topGoal.frame) {
                print("top goal")
            }
            
        default: break
        }
    }
}

