import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var timer = Timer()
    
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
    
    var collision = UICollisionBehavior()
    var collisionCenterLine = UICollisionBehavior()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(statusPack), userInfo: nil, repeats: true)
        
        
        collision = UICollisionBehavior(items: [pack, topPaddle, bottomPaddle])
        collisionCenterLine = UICollisionBehavior(items: [topPaddle, bottomPaddle])
        
        collisionCenterLine.addBoundary(withIdentifier: "centerLine" as NSCopying, from: CGPoint(x: 0, y: self.view.center.y), to: CGPoint(x: self.view.frame.width, y: self.view.center.y))
        
        collision.translatesReferenceBoundsIntoBoundary = true
        collisionCenterLine.translatesReferenceBoundsIntoBoundary = true
        
        
        animator.addBehavior(collision)
        animator.addBehavior(collisionCenterLine)
        
        self.view.bringSubviewToFront(pack)
    }
    
    @objc func statusPack() {
        if pack.frame.intersects(bottomGoal.frame) { //пересечение
            print("bottom goal")
            animator.removeBehavior(collision)
            pack.center = self.view.center
            animator.addBehavior(self.collision)
            
        }
        
        if pack.frame.intersects(topGoal.frame) {
            print("top goal")
            animator.removeBehavior(collision)
            pack.center = self.view.center
            animator.addBehavior(self.collision)
        }
        
    }
    
    
    @IBAction func topHalfPanGesture(_ sender: UIPanGestureRecognizer) {
        
        if topSnapBehavior != nil {
            animator.removeBehavior(topSnapBehavior!)
        }
        
        switch sender.state {
        case .began, .changed:
            topSnapBehavior = UISnapBehavior(item: topPaddle, snapTo: sender.location(in: self.view))
    
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
            
//            if pack.frame.intersects(bottomGoal.frame) {
//                print("bottom goal")
//
//
//            } else if pack.frame.intersects(topGoal.frame) {
//                print("top goal")
//
//            }
            
        default: break
        }
    }
}

