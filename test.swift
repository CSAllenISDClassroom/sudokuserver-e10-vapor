extension Array {
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
          self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
          self.index(endIndex, offsetBy: distance, limitedBy: startIndex)

        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    mutating func shiftInPlace(withDistance distance: Int = 1) {
        self = shift(withDistance: distance)
    }
}

func getNumberSudoku() -> [[Int]] {
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
    var preCol: [Int] = []
    var finalCol: [[Int]] = []
    var prerow: [Int] = []
    var finalRow: [[Int]] = []

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

    // Final, create the array into the [[Int]].
    return finalRow
}

func printBoard(board: [[Int]]) {
    
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
            if column == 8 && board[row][column] != 0{
                print("\(board[row][column])")
            } else if column == 8 && board[row][column] == 0 {
                print("-")
            } else if column < 8 && board[row][column] == 0 {
                print("-" + " ", terminator:"")
            } else {
                print(String(board[row][column]) + " ", terminator:"")
            }
        }
    }
}
var finalArray = [[0]]
finalArray = getNumberSudoku()
printBoard(board:finalArray)
