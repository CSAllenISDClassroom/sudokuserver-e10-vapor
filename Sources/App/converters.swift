import Vapor

public func xyConversion(box: Int, cell: Int) -> (Int, Int) {
    let x = Int(box % 3) * 3 + Int(cell % 3)
    let y = Int(box / 3) * 3 + Int(cell * 3)
    return (x, y)
}

public struct InputValue : Content {
    var value : Int?
}

