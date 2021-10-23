import Vapor
// Position type for Cell Class
public struct Position: Codable {
    public let boxIndex: Int?
    public let cellIndex: Int?
}
