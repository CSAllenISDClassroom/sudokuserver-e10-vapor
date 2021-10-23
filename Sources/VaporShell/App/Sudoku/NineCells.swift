import Foundation

public class NineCells : Codable {
    
    // NineCells will be the class which class boxes inherits
    
    public var cells : [Cell]
    
    public init(cells:[Cell]) {
        self.cells = cells        
    }

    public init(boxIndex: Int) {
        var celles = [Cell]()
        for cellIndex in 0 ..< 9 {
            celles.append(Cell(boxIndex: boxIndex, cellIndex: cellIndex))
        }
        self.cells = celles
    }
    
}
