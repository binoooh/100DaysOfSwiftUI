import Foundation

enum SquareRootErrors: Error {
    case outOfBoundsError, noRootError
}

func calcSquareRoot(_ n: Int) throws -> Int {
    var sqroot : Int = 0
    for i in n...100 {
        sqroot = (i * i) / i
        if i * i < 1 || i * i > 10_000 {
            throw SquareRootErrors.outOfBoundsError
        } else if sqroot != (i * i) / i {
            throw SquareRootErrors.noRootError
        } else {
            print("Square Root of \(i * i) is \(sqroot)")
        }
    }
    return sqroot
}

do {
    try print(calcSquareRoot(101))
} catch {
    print("Error: \(error.localizedDescription)")
}
