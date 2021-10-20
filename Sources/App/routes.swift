import Vapor

func routes(_ app: Application) throws {

    // Collects a list of boards
    var allGameData : [Board] = []
    
    app.get { req in
        return "It works!"
    }

    // an HTTP Request must have a request line, header and body

    // status line
    // Header
    // Body
    // in this case our body will be JSON data of the board ID

    app.post("games") { req -> String in
        guard let difficulty : String? = req.query["difficulty"]
        else {
            return("400 Bad Request, difficulty level not found, defaulting easy difficulty")
        }
                  
        allGameData.append(Board(boardDifficulty: difficulty ?? "easy"))     

        allGameData.append(Board(boardDifficulty: difficulty ?? "easy"))
        

        switch difficulty {

        case "easy":
            allGameData.append(Board(boardDifficulty: "easy"))
        case "medium":
            allGameData.append(Board(boardDifficulty: "medium" ))
        case "hard":
            allGameData.append(Board(boardDifficulty: "hard"))
        case "hell" :
            allGameData.append(Board(boardDifficulty: "hell"))
        case nil :
            throw Abort(.badRequest, reason: "Please put in a difficulty request. Choose a difficulty between easy,medium, hard and hell")                                      
            default :
                throw Abort(.badRequest, reason: "Your request \(difficulty) is invalid. Please choose a difficulty between easy, medium, hard and hell")
        }

        // an HTTP Request must have a request line, header and body

        // status line
        // Header
        // Body
        // in this case our body will be JSON data of the board ID

        return (" { \("id"):\(allGameData.count - 1)}, \(difficulty ?? "easy")")
    }


    app.put("games", ":id", "cells", ":boxIndex", ":cellIndex") { req -> String in
        guard let id : Int = req.parameters.get("id", as: Int.self),
              id < allGameData.count && id >= 0,
              let boxIndex = req.parameters.get("boxIndex", as: Int.self),
              boxIndex >= 0 && boxIndex < 9,
              let cellIndex = req.parameters.get("cellIndex", as: Int.self),
              cellIndex >= 0 && cellIndex < 9
        else {
            throw Abort(.badRequest, reason: "boxIndex and cellIndex MUST be integers")
        }

        //let userInput = req.body.string        
    
        guard let userInput = try? req.content.decode(InputValue.self),
              let value: Int = userInput.value,
              value >= 1 && value <= 9 else {
            throw Abort(.badRequest, reason:"Invalid syntax, parmater, or avlue in query string")
        } 
        allGameData[id].putValue(boxIndex: boxIndex, cellIndex: cellIndex, value: value)
        
        return String()
    }
           
    app.get("games", ":id", "cells") { req -> String in

        // Requests an ID, checks if they are legitimate IDs
        guard let id = req.parameters.get("id"),
              let arrayID = Int(id),
              arrayID < allGameData.count && arrayID >= 0
        else {
            throw Abort(.badRequest, reason:"arrayID invalid")
        }

        // Convert a Board object into a JSON string
        let currentGame = allGameData[arrayID]
        let jsonString = currentGame.boardJSONString()
        
        return jsonString

    }


        /*
        guard let id = req.parameters.get("id"),
              // make ID an integer so array can read it
              let arrayID = Int(id),
              arrayID < allGameData.count && arrayID >= 0
        else {
            return Response(status:HTTPResponseStatus.badRequest)
        }
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value:"application.json")
        let currentGame = allGameData[arrayID]
        let httpBody = currentGame.boardJSONString()
        print(allGameData[arrayID])
        print("====")
        print(httpBody)
        print(currentGame)
        return Response(status:HTTPResponseStatus.ok,
                        headers:headers,
                        body:Response.Body(string:httpBody))
    }
*/
}
