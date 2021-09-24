func isPossible(board: inout [[Int?]], row: Int, column: Int, number: Int) -> Bool {
    
    /*
     function which checks for row, column, and 3x3 grid if there is a duplicate number when inputted a number with its row and column.
     */
    
    
    // Checks duplicates for given row
    // iterates through 9 cells in a row and returns false if inputted value is not possible
    for i in 0 ..< 9 {
        if board[row][i] == number {
            return false
        }
    }

    // Checks duplicates for given column
    // iterates through 9 cells and returns false if inputted value is not possible
    for i in 0 ..< 9 {
        if board[i][column] == number {
            return false
        }
    }

    // Checks duplicates for given 3x3 grid
    
    // By dividing the current inputted number's column by 3 then multiplying that value by 3, this is finding the left most column within the 3x3 grid
    let leftMostColumn = (column / 3) * 3
    
    // By dividing the current inputted number's row by 3 then multiplying that value by 3, this is finding the top most row within the 3x3 grid
    let topMostRow = (row / 3) * 3
    
    // with a nested for loop, interate through 3 values within each row of the 3x3 and check if the value is sudoku legal within that 3x3 grid 
    for i in 0 ..< 3 {
        for j in 0 ..< 3 {
            if board[topMostRow+i][leftMostColumn+j] == number {
                return false
            }
        }
    }

    // if none of the checks return false, then the value's position is legal, and return true
    return true
}



func printBoard(board: [[Int?]]) {
    
    /*
     function which prints the board in a visually appealing way
     */
    
    //iterate through each row, every time 3 rows are printed, add a horizontal divider line
    for row in 0 ..< 9 {
        if row % 3 == 0 && row != 0 {
            print("----------------------- ")
        }

        //iterate through each column per row, every time 3 values are printed, create a vertical divider line
        for column in 0 ..< 9 {
            if column % 3 == 0 && column != 0 {
                print(" | ", terminator:"")
            }

            // print each value in the sudoku 2d array with correct spacing
            if column == 8 && board[row][column] != nil{
                print("\(board[row][column]!)")
            } else if column == 8 && board[row][column] == nil{
                print("-")
            } else if column < 8 && board[row][column] == nil {
                print("-" + " ", terminator:"")
            } else {
                print(String(board[row][column]!) + " ", terminator:"")
            }
        }
    }
}


func isCompleted(board: [[Int?]]) -> Bool {

    /*
     Checks if the board is completed 
     */
    
    // Iterates through the cells
    for row in 0 ..< 9 {
        for column in 0 ..< 9 {

            // If any cell is found to be empty, the function returns false
            if board[row][column] == nil {
                return false
            }
        }
    }
    return true
}



func findEmptyCell(board: [[Int?]]) -> [Int?] {
    
    /*
     Finds the next empty cell position and puts it into an array
     */

    // Iterates through the cells
    for row in 0 ..< 9 {
        for column in 0 ..< 9 {

            // If a cell is empty, return its position
            if board[row][column] == nil {
                let result = [row, column]
                return result
            }
        }
    }
    // If the board is full, return an array containing only nil
    return [nil]
}



func newSolver(board:inout [[Int?]]) -> Bool {
    
    /*
     Recursive backtracking function to solve sudoku boards
     */
    
    let found = findEmptyCell(board:board)

    // Base case
    if found[0] == nil {
        return true
    }

    // Recursive case
    else {
        let position = found

        // Starting from the lowest input possible, input and recursively attempt the next input
        for i in 1 ..< 10 {
            if isPossible(board:&board, row:position[0]!, column:position[1]!, number:i) {
                board[position[0]!][position[1]!] = i

                // Escape case
                if newSolver(board:&board) == true {
                    return true
                }

                board[position[0]!][position[1]!] = nil
            }
        }
        return false
    }
}

func createBoard(difficulty:String) -> [[Int?]] {

    /*
     Generates a new board
     */

    // Initializes an empty board
    var newBoard : [[Int?]] = [[nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],
                               [nil,nil,nil,nil,nil,nil,nil,nil,nil],]
    
    // randomize to a random cell
    let position = [Int.random(in: 0 ..< 9), Int.random(in: 0 ..< 9)]
    
    newBoard[position[0]][position[1]] = Int.random(in: 1...9)
    
    newSolver(board:&newBoard)

    // Various difficulies
    var totalCellCount = 81
    
    switch difficulty {
    case "easy" :
        // Sets the amount of clues possible 
        let endCellCount = Int.random(in: 41 ... 46)
        while totalCellCount > endCellCount {

            // Generate random positions to remove numbers from
            var rowPosition = Int.random(in: 0 ..< 9)
            var columnPosition = Int.random(in: 0 ..< 9)

            // If the position is already empty, regenerate the position
            while newBoard[rowPosition][columnPosition] == nil {
                rowPosition = Int.random(in: 0 ..< 9)
                columnPosition = Int.random(in: 0 ..< 9)           
            }

            // Set the position to empty
            newBoard[rowPosition][columnPosition] = nil
            totalCellCount -= 1
        }
    case "medium":
        let endCellCount = Int.random(in: 31 ... 36)
        while totalCellCount > endCellCount {
            
            var rowPosition = Int.random(in: 0 ..< 9)
            var columnPosition = Int.random(in: 0 ..< 9)
            
            while newBoard[rowPosition][columnPosition] == nil {
                rowPosition = Int.random(in: 0 ..< 9)
                columnPosition = Int.random(in: 0 ..< 9)           
            }
            
            newBoard[rowPosition][columnPosition] = nil
            totalCellCount -= 1
        }
    case "hard":
        let endCellCount = Int.random(in: 17 ... 26)
        while totalCellCount > endCellCount {
            
            var rowPosition = Int.random(in: 0 ..< 9)
            var columnPosition = Int.random(in: 0 ..< 9)
            
            while newBoard[rowPosition][columnPosition] == nil {
                rowPosition = Int.random(in: 0 ..< 9)
                columnPosition = Int.random(in: 0 ..< 9)           
            }
            
            newBoard[rowPosition][columnPosition] = nil
            totalCellCount -= 1
        }
    default:
        fatalError("Difficulty does not exist, use only lowercase difficulty values, ex: easy ")                         
    }
    
    return newBoard
}


// DEMO
 print("easy")
 var newBoard = createBoard(difficulty:"easy")
 printBoard(board:newBoard)
 newSolver(board:&newBoard)
 print("answer:")
 printBoard(board:newBoard)
 print("-----------------")
 print("hard")
 var sBoard = createBoard(difficulty:"hard")
 printBoard(board:sBoard)
 newSolver(board:&sBoard)
 print("answer:")
 printBoard(board:sBoard)
