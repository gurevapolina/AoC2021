import Foundation

var input = """
3,5,3,5,1,3,1,1,5,5,1,1,1,2,2,2,3,1,1,5,1,1,5,5,3,2,2,5,4,4,1,5,1,4,4,5,2,4,1,1,5,3,1,1,4,1,1,1,1,4,1,1,1,1,2,1,1,4,1,1,1,2,3,5,5,1,1,3,1,4,1,3,4,5,1,4,5,1,1,4,1,3,1,5,1,2,1,1,2,1,4,1,1,1,4,4,3,1,1,1,1,1,4,1,4,5,2,1,4,5,4,1,1,1,2,2,1,4,4,1,1,4,1,1,1,2,3,4,2,4,1,1,5,4,2,1,5,1,1,5,1,2,1,1,1,5,5,2,1,4,3,1,2,2,4,1,2,1,1,5,1,3,2,4,3,1,4,3,1,2,1,1,1,1,1,4,3,3,1,3,1,1,5,1,1,1,1,3,3,1,3,5,1,5,5,2,1,2,1,4,2,3,4,1,4,2,4,2,5,3,4,3,5,1,2,1,1,4,1,3,5,1,4,1,2,4,3,1,5,1,1,2,2,4,2,3,1,1,1,5,2,1,4,1,1,1,4,1,3,3,2,4,1,4,2,5,1,5,2,1,4,1,3,1,2,5,5,4,1,2,3,3,2,2,1,3,3,1,4,4,1,1,4,1,1,5,1,2,4,2,1,4,1,1,4,3,5,1,2,1
"""

var iterationCount = 256

var inputStrings = input
    .split(separator: "\n")
    .map({ String($0) })

var numbers = inputStrings[0]
    .split(separator: ",")
    .compactMap({ Int(String($0)) })

print(numbers)

var counts = Array(repeating: 0, count: 9)

for number in numbers {
    counts[number] += 1
}

for _ in 0..<iterationCount {
    let zerosCount = counts[0]
    for index in 0..<counts.count - 1 {
        counts[index] = counts[index + 1]
    }
    counts[6] += zerosCount
    counts[8] = zerosCount

    print(counts)
}

print(counts.reduce(0, { $0 + $1 }))

