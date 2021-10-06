import Vapor

func routes(_ app: Application) throws {
    var allGameData : [Board] = []

    app.get { req in
        return "It works!"
    }

    app.post("games") { req -> Response in
        let difficultyLevel = Difficulty.medium
        allGameData.append(Board(boardDifficulty: difficultyLevel))

        var headers = HTTPHeaders()
        headers.add(name: .contentType, value:"application/json")

        // an HTTP Request must have a request line, header and body

        // status line
        // Header
        // Body
        // in this case our body will be JSON data of the board ID

        return Response(status:HTTPResponseStatus.created,
                        headers:headers,
                        body:Response.Body(string:"{\"boardID\":\(allGameData.count - 1)}"))
    }
    
     app.get("games", ":id", "cells") { req -> Response in
     
         guard let id = req.parameters.get("id"),
               // make ID an integer so array can read it
               let arrayID = Int(id)
         else {
             return Response(status:HTTPResponseStatus.badRequest)
         }
         var headers = HTTPHeaders()
         headers.add(name: .contentType, value:"application.json")
         let currentGame = allGameData[arrayID]
         let httpBody = currentGame.boardJSONString()
         return Response(status:HTTPResponseStatus.ok,
                         headers:headers,
                         body:Response.Body(string:httpBody))
     }

     app.put("games", ":id", "cells", " :boxIndex", " :cellIndex") { req -> Response in
         guard let id : Int = req.parameters.get("id"),
               let arrayID = Int(id),
               let boxIndex = req.parameters.get("boxIndex"),
               let cellIndex = req.parameters.get("cellIndex"),
               id < games.count && id >= 0
               else {
             return Response(status:HTTPResponse.badRequest)
         }
         
         
         
               }

     

     

}

     







/*
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
 */ 
