import Vapor

func routes(_ app: Application) throws {
    var games : [Board] = []
    
    //////////////////////////////////////////////////
    // GET commands are used to retrieve a resource //
    //////////////////////////////////////////////////

    app.get { req in
        return "It works!"
    }

    // Running this GET Request will return a response with the supplied string
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name")!
        return "Hello, \(name)!"
    }

    app.post("games") { req -> Response in
        var difficultyLevel = Difficulty.medium
        do {
            if let inputDifficulty 
        }
    }
    
}

