import Vapor

func routes(_ app: Application) throws {
    var games : [Board] = []
    
    app.get { req in
        return "It works!"
    }

    app.post("games") { req -> Response in
        var difficultyLevel = Difficulty.medium
        do {
            if let inputDifficulty 
}
