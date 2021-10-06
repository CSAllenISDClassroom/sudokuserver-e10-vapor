ximport Foundation


public class Board {

    // properties of a board requires the board made up of an array of cells, rows, columns, boxes, difficulty
    var board : [[Cell]] = []
    var rows : [Row] = []
    var columns : [Column] = []
    var boxes : [Box] = []


    private var completeBoard : [[Cell]] = []






    func createRandomCompletedSudoku() -> [[Cell]] {
        // Original number
        let originalNum = [1,2,3,4,5,6,7,8,9]

        // Create line 1 to 9 and shuffle from original
        let line1 = originalNum.shuffled()
        let line2 = line1.shift(withDistance: 3)
        let line3 = line2.shift(withDistance: 3)
        let line4 = line3.shift(withDistance: 1)
        let line5 = line4.shift(withDistance: 3)
        let line6 = line5.shift(withDistance: 3)
        let line7 = line6.shift(withDistance: 1)
        let line8 = line7.shift(withDistance: 3)
        let line9 = line8.shift(withDistance: 3)
        // Final array
        let renewRow = [line1,line2,line3,line4,line5,line6,line7,line8,line9]

        // Pre-shuffle for column
        let colSh1 = [0,1,2].shuffled()
        let colSh2 = [3,4,5].shuffled()
        let colSh3 = [6,7,8].shuffled()
        let rowSh1 = [0,1,2].shuffled()
        let rowSh2 = [3,4,5].shuffled()
        let rowSh3 = [6,7,8].shuffled()

        // Create the let and var
        let colResult = colSh1 + colSh2 + colSh3
        let rowResult = rowSh1 + rowSh2 + rowSh3
        var preCol: [Int?] = []
        var finalCol: [[Int?]] = []
        var prerow: [Int?] = []
        var finalRow: [[Int?]] = []

        // Shuffle the columns
        for x in 0...8 {
            preCol.removeAll()
            for i in 0...8 {
                preCol.append(renewRow[x][colResult[i]])
            }
            finalCol.append(preCol)
        }

        // Shuffle the rows
        for x in 0...8 {
            prerow.removeAll()
            for i in 0...8 {
                prerow.append(finalCol[x][rowResult[i]])
            }
            finalRow.append(prerow)
        }

        var finalCellRow : [[Cell]] = []
        // convert integer array into cell array
        for row in 0 ... 8 {
            var singleCellRow : [Cell] = []
            for column in 0 ... 8 {
                singleCellRow.append(Cell(value:finalRow[row][column]))
            }
            finalCellRow.append(singleCellRow)
        }
        
        
        // Final, create the array into the [[Int]].
        return finalCellRow
    }

    




    
    public init(boardDifficulty : Difficulty) {
        completeBoard = createRandomCompletedSudoku()
        self.board = removeBoardCells(board:completeBoard, difficulty:boardDifficulty)
        self.rows = generateRow(board:board)
        self.columns = generateColumn(board:board)
        self.boxes = generateBox(board:board)
    }
    
    

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


    func generateColumn(board: [[Cell]]) -> [Column] {
        var columnArray : [Column] = []
        for cellArray in 0 ... 8 {
            let columns = Column(cells:[Cell()])
            for cell in 0 ... 8 {
                columns.cells.append(board[cell][cellArray])
            }
            columnArray.append(columns)
        }
        return columnArray
    }

    func generateBox(board: [[Cell]]) -> [Box] {
        var boxes : [Box] = []
        for offSetValues in 0 ... 8 {
            let columnOffSet = (offSetValues % 3) * 3
            let rowOffSet = (offSetValues / 3) * 3
            let box = Box(cells:[Cell()])
            for values in 0 ... 8 {
                box.cells.append(board[rowOffSet + (values / 3)] [columnOffSet + (values / 3)])
            }
            boxes.append(box)
        }
        return boxes
    }


    

    
    public func removeBoardCells(board:[[Cell]],difficulty:Difficulty) -> [[Cell]] {        
        let newBoard = board
        var totalCellCount = 81
        
        switch difficulty {
            
        case .easy :
            let endCellCount = Int.random(in: 41 ... 46)
            while totalCellCount > endCellCount {

                var rowPosition = Int.random(in: 0 ... 8)
                var columnPosition = Int.random(in: 0 ... 8)

                while newBoard[rowPosition][columnPosition].value == nil {
                    rowPosition = Int.random(in: 0 ... 8)
                    columnPosition = Int.random(in: 0 ... 8)
                }

                newBoard[rowPosition][columnPosition].nilValue()
                totalCellCount -= 1                

            }
            
        case .medium :
        let endCellCount = Int.random(in: 31 ... 36)
        while totalCellCount > endCellCount {

            var rowPosition = Int.random(in: 0 ... 8)
            var columnPosition = Int.random(in: 0 ... 8)

            while newBoard[rowPosition][columnPosition].value == nil {
                rowPosition = Int.random(in: 0 ... 8)
                columnPosition = Int.random(in: 0 ... 8)
            }

            newBoard[rowPosition][columnPosition].nilValue()
            totalCellCount -= 1                

        }
        
        case .hard :
            let endCellCount = Int.random(in: 17 ... 26)
            while totalCellCount > endCellCount {

                var rowPosition = Int.random(in: 0 ... 8)
                var columnPosition = Int.random(in: 0 ... 8)

                while newBoard[rowPosition][columnPosition].value == nil {
                    rowPosition = Int.random(in: 0 ... 8)
                    columnPosition = Int.random(in: 0 ... 8)
                }

                newBoard[rowPosition][columnPosition].nilValue()
                totalCellCount -= 1                

            }

        default:
            fatalError("Difficulty does not exist, choose between easy, medium, or hard")
        }
        return newBoard
    }

    
    func boardJSONString(board:[[Cell]]) -> String {
        let board = board
        var jsonString = ""
        let encoder = JSONEncoder()

        for rows in 0 ... 8 {
            for cells in 0 ... 8 {
                guard let data = try? encoder.encode(board[rows][cells]),
                      let string = String(data: data, encoding: .utf8) else {
                    fatalError("Failed to encode data into json.")
                }
                jsonString += "\(string),"
                
        }
        }
        return jsonString
    }


        



    

    
}

