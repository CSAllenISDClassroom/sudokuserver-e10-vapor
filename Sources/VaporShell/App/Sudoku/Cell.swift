import Vapor
import Foundation

public class Cell : Codable  {

    // Cell class stores a value, and a position which can be determined in higher object levels such as board and box class

    public var position : Position 
    public var value: Int?        
    init() {
        self.position = Position(boxIndex:nil, cellIndex:nil)
        self.value = nil        
    }

    init(value:Int?) {
        self.position = Position(boxIndex:nil, cellIndex:nil)
        self.value = value
    }

    init(boxIndex: Int, cellIndex: Int) {
        self.value = nil
        self.position = Position(boxIndex:boxIndex, cellIndex:cellIndex)
    }

    
    init(value:Int?, boxIndex:Int, cellIndex: Int) {
        self.position = Position(boxIndex:boxIndex, cellIndex:cellIndex)
        self.value = value        
    }

    public func mutateValue(_ num:Int?) {
        self.value = num
    }

    public func mutatePosition(_ boxIndex: Int, _ cellIndex: Int) {
        self.position = Position(boxIndex: boxIndex, cellIndex: cellIndex)
    }
    


    // change an integer value into a nil
    public func nilValue() {
        precondition(value != nil, "Value is already nil, needs an integer value")
        self.value = nil
    }
}
