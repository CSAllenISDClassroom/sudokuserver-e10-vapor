import Foundation


public class Board : Codable {
    
//    create the properties of the board class
    var board : [Box] = []
    var boxes : [Box] = []
    private var completedBoxes : [Box] = []

    private var completeBoard : [[Cell]] = []

    // This function created a random completed sudoku board
    private func createRandomCompletedSudoku() -> [[Cell]] {
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
    

    
    // Initializes the board difficulty
    public init(boardDifficulty : String) {
        completeBoard = createRandomCompletedSudoku()
        self.board = removeBoardCells(board:completeBoard, difficulty:boardDifficulty)
        self.boxes = generateBox(board:completeBoard)
        self.completedBoxes = generateBox(board:completeBoard)
    }
    
    public func filter(filter: String) -> String {
        let board = board
        let completedBoard = completedBoxes
        var incorrectCells : [Cell] = []
        let encoder = JSONEncoder()
        
        switch filter {

        case "all":
            let toJSONBoard = board
            
            var finalJSON : String = "{\"board\":"
            guard let data = try? encoder.encode(toJSONBoard),
                  let json = String(data: data, encoding: .utf8)
            else {
                fatalError("Failed to encode data into JSON.")            
            }
            finalJSON += json
            finalJSON += "}"
            return finalJSON
            
        case "incorrect":
            
            for boxIndex in 0 ..< 9 {                
                for cellIndex in 0 ..< 9 {
                    if board[boxIndex].cells[cellIndex].value != completedBoard[boxIndex].cells[cellIndex].value {
                        incorrectCells.append(board[boxIndex].cells[cellIndex])
                    }
                }
            }
            let toJSONCells = incorrectCells
            
            var finalJSON : String = "{\"board\":"
            guard let data = try? encoder.encode(toJSONCells),
                  let json = String(data: data, encoding: .utf8)
            else {
                fatalError("Failed to encode data into JSON.")            
            }
            finalJSON += json
            finalJSON += "}"
            return finalJSON
/* WIP
        case "repeated":
            let checkedBoxes = board
            for boxIndex in 0 ..< 9 {
                for cellIndex in 0 ..< 9 {
                    let valueInQuestion = board[boxIndex].cells[cellIndex]
                    if cellIndex = 0 || cellIndex = 1 || cellIndex = 2 && boxIndex < 2{
                        for subBoxIndex in 0 ... 2 {
                            for subCellIndex in 0 ... 2{
                                
                            }
                        }
                        
                    }
                }
                
                             
                         }
                         
 */
            
        default :
            fatalError("Bad Request, use a valid filter")
        }
        

    }
    // This function converts the board to be in terms of boxes and cells rather than rows and columns
    private func generateBox(board: [[Cell]]) -> [Box] {
        var boxes = [Box]()
                
        let box1 = Box(boxIndex: 0)
        let box2 = Box(boxIndex: 1)
        let box3 = Box(boxIndex: 2)
        let box4 = Box(boxIndex: 3)
        let box5 = Box(boxIndex: 4)
        let box6 = Box(boxIndex: 5)
        let box7 = Box(boxIndex: 6)
        let box8 = Box(boxIndex: 7)
        let box9 = Box(boxIndex: 8)
        
        for row in 0 ... 8 {
            for column in 0 ... 8 {

                if row < 3 && column < 3 {
                    let currentCell = board[row][column]
                    box1.cells[column].mutateValue(currentCell.value)
                }
                if row < 3 && column < 6 && column > 2 {
                    let currentCell = board[row][column]
                    box2.cells[column].mutateValue(currentCell.value)
                }
                if row < 3 && column < 9 && column > 5 {
                    let currentCell = board[row][column]
                    box3.cells[column].mutateValue(currentCell.value)                                      
                }
                if  column < 3 && row < 6 && row > 2 {
                    let currentCell = board[row][column]
                    box4.cells[column].mutateValue(currentCell.value)
                }
                if column < 6 && column > 2 && row < 6 && row > 2 {
                    let currentCell = board[row][column]
                    box5.cells[column].mutateValue(currentCell.value)
                }
                if row > 2 && row < 6 && column < 9 && column > 5 {
                    let currentCell = board[row][column]
                    box6.cells[column].mutateValue(currentCell.value)
                }
                if row > 5 && row < 9 && column < 3 {
                    let currentCell = board[row][column]
                    box7.cells[column].mutateValue(currentCell.value)
                }
                if row > 5 && row < 9 && column > 2 && column < 6 {
                    let currentCell = board[row][column]
                    box8.cells[column].mutateValue(currentCell.value)
                }
                if row > 5 && row < 9 && column > 5 && column < 9 {
                    let currentCell = board[row][column]
                    box9.cells[column].mutateValue(currentCell.value)
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
    private func removeBoardCells(board:[[Cell]],difficulty:String) -> [Box] {        
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
     

    func toJSON() -> String {
        let toJSONBoard = board
        let encoder = JSONEncoder()
        var finalJSON : String = "{\"board\":"
        guard let data = try? encoder.encode(toJSONBoard),
              let json = String(data: data, encoding: .utf8)
        else {
            fatalError("Failed to encode data into JSON.")            
        }
        finalJSON += json
        finalJSON += "}"
        return finalJSON
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
    
        



    
    
}

