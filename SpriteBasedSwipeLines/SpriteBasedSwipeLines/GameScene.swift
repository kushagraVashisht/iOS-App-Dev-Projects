import SpriteKit

class GameScene: SKScene
    {
    var blade: SWBlade?
    var delta: CGPoint = .zero
    override func didMove(to view: SKView) {
        backgroundColor = .black
    }
    
    // MARK: - SWBlade Functions
    
    func presentBladeAtPosition(_ position:CGPoint) {
        blade = SWBlade(position: position, target: self, color: .white)
        
        guard let blade = blade else {
            fatalError("Blade could not be created")
        }
        
        addChild(blade)
    }
    
    func removeBlade() {
        delta = .zero
        blade!.removeFromParent()
    }
    
    // MARK: - Touch Events
    
    override func touchesBegan(_ touches: Set, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        presentBladeAtPosition(touchLocation)
    }
    
    override func touchesMoved(_ touches: Set, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let currentPoint = touch.location(in: self)
        let previousPoint = touch.previousLocation(in: self)
        delta = CGPoint(x: currentPoint.x - previousPoint.x, y: currentPoint.y - previousPoint.y)
    }
    
    override func touchesEnded(_ touches: Set, with event: UIEvent?) {
        removeBlade()
    }
    
    override func touchesCancelled(_ touches: Set, with event: UIEvent?) {
        removeBlade()
    }
    // MARK: - FPS
    
    override func update(_ currentTime: TimeInterval) {
        // if the blade is not available return
        guard let blade = blade else {
            return
        }
        
        // Here you add the delta value to the blade position
        let newPosition = CGPoint(x: blade.position.x + delta.x, y: blade.position.y + delta.y)
        // Set the new position
        blade.position = newPosition
        // it's important to reset delta at this point,
        // You are telling the blade to only update his position when touchesMoved is called
        delta = .zero
    }
}
