import Vapor

public func xyConversion(box: Int, cell: Int) -> (Int, Int) {
    let x = Int(box % 3) * 3 + Int(cell % 3)
    let y = Int(box / 3) * 3 + Int(cell * 3)
    return (x, y)
}

public func toDifficulty(inputDifficulty:String) -> Difficulty{
    var returnValue : Difficulty
    switch inputDifficulty {
    case "easy":
        returnValue = Difficulty.easy
    case "medium":
        returnValue = Difficulty.medium
    case "hard":
        returnValue = Difficulty.hard
    default:
        returnValue = Difficulty.medium
        print("Reached default difficulty switch case: Setting Difficulty to medium")
    }
    return returnValue
}

public struct InputValue : Content {
    var value : Int?
}

public struct InputDifficulty : Content {
    var difficult : String?
}
