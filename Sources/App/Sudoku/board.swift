import Foundation


public class Board {

    // properties of a board requires the board made up of an array of cells, rows, columns, boxes, difficulty
    var board : [[Cell]]
    var rows : [Row]
    var columns : [Column]
    var boxes : [Box]
    var difficulty : Difficulty


    public init() {

    }
    
    
    var newBoard = [
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
      [Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell(),Cell()],
    ]


    func generateRow(board: [[Cell]]) -> [Row] {
        var rowArray : [Row] = []
        // iterate through each array in a board, then iterate through each element of each array
        for cellArray in 0 ... 8 {
            let rows = Row(cells:[Cell()])
            for cell in 0 ... 8 {
                rows.cells.append(board[cellArray][cell])
            }            
            rowArray.append(rows)
        }        
        return rowArray
    }


    
    // function to check whether a position is possible or not
    
    
}
