import Foundation


public class Board {

    // properties of a board requires the board made up of an array of cells, rows, columns, boxes, difficulty
    //    var board : [[Cell]] = []
    var board : [Box] = []
    var rows : [Row] = []
    var columns : [Column] = []
    var boxes : [Box] = []

    private var completeBoard : [[Cell]] = []

    // This function created a random completed sudoku board
    func createRandomCompletedSudoku() -> [[Cell]] {
        // Original number
        let originalNum = [1,2,3,4,5,6,7,8,9]

        // Create line 1 to 9 and shuffle from original
        let line1 = originalNum.shuffled() // creates shuffled array with numbers 1-9
        let line2 = line1.shift(withDistance: 3) //shifts the array by 3
        let line3 = line2.shift(withDistance: 3) //shifts previous array by 3
        let line4 = line3.shift(withDistance: 1) //shifts previous array by 1
        let line5 = line4.shift(withDistance: 3) // ...
        let line6 = line5.shift(withDistance: 3)
        let line7 = line6.shift(withDistance: 1)
        let line8 = line7.shift(withDistance: 3)
        let line9 = line8.shift(withDistance: 3)
        // Final array with all of the shifts
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
    
/*
  func convertTest(rowIndex: Int, columnIndex: Int) {
        var boxIndex = 0
        var cellIndex = 0                
    }    
 */
    
    // Initializes the board difficulty
    public init(boardDifficulty : String) {
        completeBoard = createRandomCompletedSudoku()
        self.board = removeBoardCells(board:completeBoard, difficulty:boardDifficulty)
        self.rows = generateRow(board:completeBoard)
        self.columns = generateColumn(board:completeBoard)
        self.boxes = generateBox(board:completeBoard)
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
            // repeated(array: cellArray) // should return each row but with only the repeated cell values
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
/*    
    func generateBox(board: [[Cell]]) -> [Box] {
        var boxes : [Box] = []
        for offSetValues in 0 ... 8 {
            let columnOffSet = (offSetValues % 3) * 3 // 0,3,6,0,3,6
            let rowOffSet = (offSetValues / 3) * 3 // 0,3,6,0,3,6
            let box = Box(cells:[Cell()])
            for values in 0 ... 8 {
                box.cells.append(board[rowOffSet + (values % 3)] [columnOffSet + (values / 3)])
            }
            boxes.append(box)
        }
        return boxes
    }
*/
    // This function converts the board to be in terms of boxes and cells rather than rows and columns
    func generateBox(board: [[Cell]]) -> [Box] {
        var boxes = [Box]()
        let box1 = Box(cells:[Cell()])
        let box2 = Box(cells:[Cell()])
        let box3 = Box(cells:[Cell()])
        let box4 = Box(cells:[Cell()])
        let box5 = Box(cells:[Cell()])
        let box6 = Box(cells:[Cell()])
        let box7 = Box(cells:[Cell()])
        let box8 = Box(cells:[Cell()])
        let box9 = Box(cells:[Cell()])
        
        for row in 0 ... 8 {
            for column in 0 ... 8 {

                if row < 3 && column < 3 {
                    let currentCell = board[row][column]
                    box1.cells.append(currentCell)
                }
                if row < 3 && column < 6 && column > 2 {
                    let currentCell = board[row][column]
                    box2.cells.append(currentCell)
                }
                if row < 3 && column < 9 && column > 5 {
                    let currentCell = board[row][column]
                    box3.cells.append(currentCell)
                }
                if  column < 3 && row < 6 && row > 2 {
                    let currentCell = board[row][column]
                    box4.cells.append(currentCell)
                }
                if column < 6 && column > 2 && row < 6 && row > 2 {
                    let currentCell = board[row][column]
                    box5.cells.append(currentCell)
                }
                if row > 2 && row < 6 && column < 9 && column > 5 {
                    let currentCell = board[row][column]
                    box6.cells.append(currentCell)
                }
                if row > 5 && row < 9 && column < 3 {
                    let currentCell = board[row][column]
                    box7.cells.append(currentCell)
                }
                if row > 5 && row < 9 && column > 2 && column < 6 {
                    let currentCell = board[row][column]
                    box8.cells.append(currentCell)
                }
                if row > 5 && row < 9 && column > 5 && column < 9 {
                    let currentCell = board[row][column]
                    box9.cells.append(currentCell)
                }

            }
            //boxes.append(box)
            //box.removeAll()
        }
        //}
        boxes.append(box1)
        boxes.append(box2)
        boxes.append(box3)
        boxes.append(box4)
        boxes.append(box5)
        boxes.append(box6)
        boxes.append(box7)
        boxes.append(box8)
        boxes.append(box9)
        
        return boxes // boxes[0-8][0-8]
        
    }

    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    // Function that removes board cells based on the difficulty (higher difficulty = more removed) //
    //////////////////////////////////////////////////////////////////////////////////////////////////
    public func removeBoardCells(board:[[Cell]],difficulty:String) -> [Box] {        
        let newBoard = board
        var totalCellCount = 81
        
        switch difficulty {            
        case "easy" :
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
            
        case "medium" :
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
        
        case "hard" :
            let endCellCount = Int.random(in: 21 ... 27)
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

        case "hell" :
            let endCellCount = Int.random(in: 17 ... 20)
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
            fatalError("Difficulty does not exist, choose between easy, medium, hard, or hell")
        }
        return generateBox(board:newBoard)
    }

    ////////////////////////////////////////////////////////////
    // This function converts the board data into JSON format //
    ////////////////////////////////////////////////////////////
    public func boardJSONString() -> String {
        let board = board
        var s : String = "{\"board\":["
        for b in 0 ..< board.count {
            s += "{\"cells\":["
            var addedACell = false
            for c in 0 ..< 9 { // type of expression is ambigious without more context
                //let tile = board[b][c]
                //let pos = BCtoXY(b:b,c:c)
                //if shouldBeFiltered(filter:filter, xPos:pos.0, yPos:pos.1) {continue}
                s += "{\"position\":{\"boxIndex\":\(b),\"cellIndex\":\(c)},\"value\":"
                //if tile.value == nil {s += "null"}
                //else {
                let appendBox = board[b].cells[c].value
                //s += String(appendBox)
                if appendBox == nil {
                    s += String(describing:appendBox)
                } else {
                    s += "\(appendBox!)"
                }
                //print(appendBox)
                //s += String(boxes[b][c])
                 // }
                s += "},"
                addedACell = true
            }
            s += "\n"
            if addedACell { s = String(s[...s.index(s.endIndex, offsetBy:-2)]) }
            if b == board.count-1 {s += "]}"}
            else {s += "]},"}
        }
        s += "]}"
        print(s)
        return s
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    // This function is used by the PUT command in order to insert/replace a value in a cell //
    ///////////////////////////////////////////////////////////////////////////////////////////
    func putValue(boxIndex: Int, cellIndex: Int, value: Int) {
        self.board[boxIndex].cells[cellIndex].value = value
    }


    func convertBCtoRC(boxIndex: Int, cellIndex: Int) -> (Int, Int) {

        /*                      
           Given an input of boxIndex and cellIndex format, this function returns a translation into row and column format for the board. 
         */
        
        var convertedRow = Int()
        var convertedColumn = Int()

        // Locate top left of each box
        if boxIndex == 0 || boxIndex == 1 || boxIndex == 2 {
            convertedRow = 0
            if boxIndex == 0 {
                convertedColumn = 0
            } else if boxIndex == 1 {
                convertedColumn = 3
            } else if boxIndex == 2 {
                convertedColumn = 6
            }
        }
        else if boxIndex == 3 || boxIndex == 4 || boxIndex == 5 {
            convertedRow = 3
            if boxIndex == 3 {
                convertedColumn = 0
            } else if boxIndex == 4 {
                convertedColumn = 3
            } else if boxIndex == 5 {
                convertedColumn = 6
            }
        }
        else if boxIndex == 6 || boxIndex == 7 || boxIndex == 8 {
            convertedRow = 6
            if boxIndex == 6 {
                convertedColumn = 0
            } else if boxIndex == 7 {
                convertedColumn = 3
            } else if boxIndex == 8 {
                convertedColumn = 6
            }
        }

        // Manipulate positioning based on cellIndex
        if cellIndex == 1{
            convertedColumn += 1
        }
        else if cellIndex == 2{
            convertedColumn += 2
        }
        else if cellIndex == 3{
            convertedRow += 1
        }
        else if cellIndex == 4{
            convertedRow += 1
            convertedColumn += 1
        }
        else if cellIndex == 5{
            convertedRow += 1
            convertedColumn += 2
        }
        else if cellIndex == 6{
            convertedRow += 2
        }
        else if cellIndex == 7{
            convertedRow += 2
            convertedColumn += 1
        }
        else if cellIndex == 8{
            convertedRow += 2
            convertedColumn += 2
        }

        let result = (convertedRow, convertedColumn)
        return result
    }
    
    

    // WIP
    // This function will be used for the repeated filter in the GET
    // Requires an array of integers input, then outputs that array with only the duplicate numbers
    func repeated(array: [Int?]) -> [Int]{

        var duplicatesArray = [Int]()
        var prevElement : Int = -1
        var prevprevElement : Int = -1
        var sortedArray = [Int]()

        for optionalElement in array {
            if optionalElement != nil {
                sortedArray.append(optionalElement!)
            }
        }
        sortedArray = sortedArray.sorted()


        for element in sortedArray {
            if(prevElement == element) {
                duplicatesArray.append(element)
                if prevprevElement != prevElement {
                    duplicatesArray.append(prevElement)
                }
            }
            prevprevElement = prevElement
            prevElement = element
        }
        return duplicatesArray
    }
    



    
    
}

