import Vapor

func routes(_ app: Application) throws {
    //array of boards
    var games : [Board] = []
    
    app.get { req in
        return "It works!"
    }

    app.post("games", difficultyLevel: .Difficulty) { req -> Response in
        var difficultyLevel = Difficulty.medium
        do {
            guard let inputDifficulty = req.parameters.get("name")
            else {
                return Response(status:.badRequest)
            }
            difficultyLevel = inputDifficulty
        }
    }
}
