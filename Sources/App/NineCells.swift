class NineCells {
    
    var cells : [Cell] = []

    init(cells:[Cell]){
        self.cells = cells
    }
    
    public func checkValue(inputValue : Int) -> Bool {
        var doesValueWork = true
        for value in 0 ..< cells.count {
            if cells[value] = inputValue{
                doesValueWork = false
            }
            
        }
        return doesValueWork
    }

    public func possibleValues(cellPosition:Int) -> [Int]{
        var possibleValues : [Int] = []
        for integer in 1...9 {
            if checkValue(inputValue: integer) {
                possibleValues.append(integer)
            }

        
        }
    }
}
