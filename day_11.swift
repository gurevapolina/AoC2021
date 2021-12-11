import Foundation

var input = """
8548335644
6576521782
1223677762
1284713113
6125654778
6435726842
5664175556
1445736556
2248473568
6451473526
"""

let inputStrings = input
    .split(separator: "\n")
    .map({ String($0) })

var matrix = inputStrings.map({ $0.map({ Int(String($0)) ?? 0 }) })

let size = 10

// Part 1

let days = 100
var flashCount = 0
var flashedLocations: [(Int, Int)] = []

func flash(row: Int, column: Int) {
    if flashedLocations.contains(where: { $0 == row && $1 == column }) {
        return
    }
    else if matrix[row][column] < 9 {
        matrix[row][column] += 1
        return
    }

    flashedLocations.append((row, column))
    flashCount += 1
    matrix[row][column] = 0

    // top 3
    if row - 1 >= 0 && column - 1 >= 0 {
        flash(row: row - 1, column: column - 1)
    }
    if row - 1 >= 0 {
        flash(row: row - 1, column: column)
    }
    if row - 1 >= 0 && column + 1 < size {
        flash(row: row - 1, column: column + 1)
    }

    // bottom 3
    if row + 1 < size && column - 1 >= 0 {
        flash(row: row + 1, column: column - 1)
    }
    if row + 1 < size {
        flash(row: row + 1, column: column)
    }
    if row + 1 < size && column + 1 < size {
        flash(row: row + 1, column: column + 1)
    }

    // side
    if column - 1 >= 0 {
        flash(row: row, column: column - 1)
    }
    if column + 1 < size {
        flash(row: row, column: column + 1)
    }
}

for _ in 0..<days {

    for row in 0..<size {
        for column in 0..<size {
            matrix[row][column] += 1
        }
    }

    for row in 0..<size {
        for column in 0..<size {
            if matrix[row][column] == 10 {
                flash(row: row, column: column)
            }
        }
    }

    flashedLocations = []
}

print(flashCount)

// Part 2

matrix = inputStrings.map({ $0.map({ Int(String($0)) ?? 0 }) })
flashedLocations = []

var sum = -1
var daysCount = 0

while sum != 0 {

    for row in 0..<size {
        for column in 0..<size {
            matrix[row][column] += 1
        }
    }

    for row in 0..<size {
        for column in 0..<size {
            if matrix[row][column] == 10 {
                flash(row: row, column: column)
            }
        }
    }

    flashedLocations = []

    sum = matrix.flatMap({$0}).reduce(0, { $0 + $1 })
    daysCount += 1
}

print(daysCount)
