/*
public class BoardID {

    public var boardID : [Int: Board] = [:]


  
    
    public func createBoardID(difficulty:String){
        var board = Board.init()
        board.createBoard(difficulty: difficulty)
        let generateBoardID = Int.random(in: 0...9999)

        for (key,_) in boardID {

            if key != generateBoardID {
                boardID[generateBoardID] = board
            }
        }

    }
    
}
 */

public class BoardID {

    var boards : [Board] = []

    public func giveID() -> Int {
        return boards.count
    }


}
