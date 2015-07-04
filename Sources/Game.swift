import Foundation



public enum Facing {
    case Up, Right, Down, Left
}

public struct Position: Hashable {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public var hashValue: Int {
        get {
            return self.x.hashValue + self.y.hashValue
        }
    }
}

public func ==(lhs:Position, rhs: Position) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

public class Participant: Hashable {
    
    public var position: Position
    public var facing: Facing
    var name: String
    
    public var hashValue: Int {
        get {
            return self.position.hashValue + self.facing.hashValue + self.name.hashValue
        }}
    
    public required init(placed: Position, facing: Facing, name: String) {
        self.position = placed
        self.facing = facing
        self.name = name
    }
    
    public convenience init (name: String) {
        let defaultPosition = Position(x: 0,y: 0)
        let defaultFacing = Facing.Right
        self.init(placed: defaultPosition, facing: defaultFacing, name: name)
    }
}

public func ==(lhs: Participant, rhs: Participant) -> Bool {
    return lhs.position == rhs.position &&
        lhs.facing == rhs.facing &&
        lhs.name == rhs.name
}

public class Board {
    
    public var width: Int = 10
    public var height: Int = 10
    public var participants = Set<Participant>()
    
    public required init (h: Int, w: Int) {
        if ((h > 0) && (w > 0)) {
            self.height = h;
            self.width = w;
        }
    }
    
    public func addParticipant(joining: Participant) {
        self.participants.insert(joining)
    }
    
}