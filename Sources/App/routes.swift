import Vapor

func routes(_ app: Application) throws {
    //array of boards
    var games : [Board] = []
    
    //////////////////////////////////////////////////
    // GET commands are used to retrieve a resource //
    //////////////////////////////////////////////////

    app.get { req in
        return "It works!"
    }


    app.post("games") { req -> Response in
        var difficultyLevel = Difficulty.medium

        do {
            guard let inputDifficulty = Board(difficulty: Difficulty.self)
            else {
                return Response(status:.badRequest)
            }
            difficultyLevel = inputDifficulty
        }
        catch{
            print("[\(games.count)] No inputDifficulty received: Setting difficulty to medium (default)")
        }
        print("[\(games.count)] Difficulty:\(difficultyLevel). ", terminator:"")
        games.append(Board(difficulty:difficultyLevel))
        let body = "{\"boardID\":\(games.count-1)}"
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value:"application/json")
        return Response(status:HTTPResponseStatus.created,
                        headers:headers,
                        body:Response.Body(string:body))
    }    
}
