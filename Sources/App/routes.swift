import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("easyGame") { req -> String in
        let board = BoardID.createBoardID(difficulty:"easy")
        return "\(BoardID.boardID)"
    }
}
