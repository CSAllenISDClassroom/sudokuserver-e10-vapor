import Foundation

public class NineCells : Codable {
    
    // Class NineCells denotes the parent class of Class Row, Column, and Box, and contains an array of Cells
    
    public var cells : [Cell]
    
    public init(cells:[Cell]) {
        self.cells = cells        
    }
    
}
