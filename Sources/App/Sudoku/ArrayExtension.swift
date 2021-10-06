// creates Array extension for sudoku board row shifting
// this extension is adding new functionality to Arrays, more specifically allowing us to use '.shift' to move the elements of an array left to right, taking the right most integer and making its index 0, shifting the array the desired distance
extension Array {


    // returns a new array with the first elements up to a specified distance being shifted to the end of the collection
    // works with negative inputs and will reverse the order of the array
    // if the distance given exceeds the number of elements in the given array, the elements will not be shifted

    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
          self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
          self.index(endIndex, offsetBy: distance, limitedBy: startIndex)

        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
}
