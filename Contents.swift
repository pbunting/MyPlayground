import UIKit
import SpriteKit
import XCPlayground

//Create the SpriteKit View
let view:SKView = SKView(frame: CGRectMake(0, 0,512, 384))


//Create the scene and add it to the view
let scene:SKScene = SKScene(size: CGSizeMake(1024, 768))
scene.scaleMode = SKSceneScaleMode.Fill
view.allowsTransparency = false
scene.size
scene.backgroundColor = UIColor.whiteColor()
view.presentScene(scene)

scene.scaleMode

//Add it to the TimeLine
XCPShowView("Live View", view: view)

//
//: This is a line of text that will appear as a rich comment in a playground.

//: These two lines of single delimiter text
//: show up as one rich comment block in the playground





/*: Create a bulleted list of animals
### Some Animals
* Cat
* Dog
* Llama
*/


let board1 = Board(h: 5, w: 5)
let harrison = Participant(placed: Position(x: 0, y: 0), facing: Facing.Right, name: "Harrison")
board1.addParticipant(harrison)

public struct BoardSpriteKitParams {
    let scn: SKScene
    let placeWidth: Double
    let placeHeight: Double
    
    internal init(scene: SKScene, x: Int, y: Int) {
        self.scn = scene
        self.placeHeight = Double(scene.size.height) / Double(y)
        self.placeWidth = Double(scene.size.width) / Double(x)
    }

    func getPlaceOrigin(pos: Position) -> CGPoint {
        let xO = Double(pos.x) * placeWidth + (placeWidth / 2)
        let yO = Double(pos.y) * placeHeight + (placeHeight / 2)
        return CGPointMake(CGFloat(xO), CGFloat(yO))
    }
    
}

// Harrison's game idea
// Fishing game. Hit a to strike when a fish bites. The bigger the fish the faster you need to tap a

extension Board {
    
    public func getParams(scene: SKScene) -> BoardSpriteKitParams {
        return BoardSpriteKitParams(scene: scene, x: self.width, y: self.height)
    }
    
    func emptyBoardPlace(parameters: BoardSpriteKitParams, pos: Position) -> SKShapeNode {
        let placeShape = SKShapeNode(rectOfSize: CGSizeMake(CGFloat(parameters.placeWidth), CGFloat(parameters.placeHeight)))
        placeShape.position = parameters.getPlaceOrigin(pos)
        placeShape.fillColor = UIColor.blueColor()
        placeShape.strokeColor = UIColor.blackColor()
        placeShape.lineWidth = 3
        return placeShape
    }
    
    func player(parameters: BoardSpriteKitParams, pos: Position) -> SKShapeNode {
        let xOffset = CGFloat((0.5 * parameters.placeWidth) / 2.0)
        let yOffset = CGFloat((0.75 * parameters.placeHeight) / 2.0)
        
        let ref = CGPathCreateMutable()
        CGPathMoveToPoint(ref, nil, -1 * xOffset,  -1 * yOffset)
        CGPathAddLineToPoint(ref, nil, 0, yOffset)
        CGPathAddLineToPoint(ref, nil, xOffset, -1 * yOffset)
        CGPathAddLineToPoint(ref, nil, -1 * xOffset, -1 * yOffset)

        let playerShape = SKShapeNode(path: ref)
        playerShape.position = parameters.getPlaceOrigin(pos)
        playerShape.fillColor = UIColor.yellowColor()
        playerShape.strokeColor = UIColor.blackColor()
        playerShape.lineWidth = 3
        
        return playerShape
    }
    
    public func render(params: BoardSpriteKitParams) {
        
        for xIndex in 0 ..< self.width {
            for yIndex in 0 ..< self.height {
                params.scn.addChild(emptyBoardPlace(params, pos: Position(x: xIndex, y: yIndex)))
            }
        }
        
        for participant in self.participants {
            params.scn.addChild(player(params, pos:participant.position))
        }
    }
}

let p = board1.getParams(scene)
board1.render(p)


//Add something to it!
let redBox:SKSpriteNode = SKSpriteNode(color: SKColor.redColor(), size:CGSizeMake(300, 300))
redBox.position = CGPointMake(512, 384)
redBox.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(6, duration: 2)))
scene.addChild(redBox)

