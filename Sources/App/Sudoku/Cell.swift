import Vapor
import Foundation

public class Cell : Codable  {

    public var value : Int?

    init() {
        self.value = nil
    }

    init(value:Int?) {
        self.value = value
    }
    


    public func mutateValue(_ num:Int) {
        self.value = num
    }


    // change an integer value into a nil
    public func nilValue() {
        precondition(value != nil, "Value is already nil, needs an integer value")
        self.value = nil
    }
}
