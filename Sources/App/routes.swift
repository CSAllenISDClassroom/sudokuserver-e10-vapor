import Vapor

func routes(_ app: Application) throws {
    var allGameData : [Board] = []
    
    app.get { req in
        return "It works!"
    }

    app.post("games") { req -> String in
        //        let difficulty = try req.query.decode(Difficulty.self)
        guard let difficulty : String? = req.query["difficulty"]
        else {
            return("400 Bad Request, difficulty level not found, defaulting easy difficulty")
        }
        
        /*
                  else {
            return ("400 Bad Request, difficulty level not found")
                  }
                  
         */
                  
        allGameData.append(Board(boardDifficulty: difficulty ?? "easy"))

        // an HTTP Request must have a request line, header and body

        // status line
        // Header
        // Body
        // in this case our body will be JSON data of the board ID

        return (" { \("id"):\(allGameData.count - 1)}, \(difficulty ?? "easy")")
    }

    /*
     app.get("games", ":id", "cells") { req -> Response in
     
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


     app.put("games", ":id", "cells", " :boxIndex", " :cellIndex") { req -> Response in
         guard let id : Int = req.parameters.get("id"),
               let boxIndex : Int = req.parameters.get("boxIndex"),
               let cellIndex : Int = req.parameters.get("cellIndex"),
               id < allGameData.count && id >= 0,
               boxIndex >= 0 && boxIndex < 9,
               cellIndex >= 0 && cellIndex < 9
         else {
             return Response(status:HTTPResponseStatus.badRequest)
         }

         var input : Int? = nil
         let place = xyConversion(box: boxIndex, cell: cellIndex)

         if let inputValue = try req.content.decode(InputValue.self).value {
             guard inputValue >= 1 && inputValue <= 9 else {
                 return Response(status:.badRequest)
             }
             input = inputValue
         }
         
         print("[\(id)] Added \(String(describing:input)) at (\(place.0), \(place.1)).")
         return Response(status:HTTPResponseStatus.noContent)
     }
                
}         
       

       
     */
}
