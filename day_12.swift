import Foundation

typealias Vertex = String

extension Vertex {
    var isSmall: Bool {
        return self == self.lowercased()
    }
}

class AdjacencyList {
    var adjacencyDict: [Vertex: [Vertex]] = [:]

    init() {}

    func createVertex(name: String) -> Vertex {
        if adjacencyDict[name] == nil {
            adjacencyDict[name] = []
        }
        return name
    }

    func adjacentVertices(source: Vertex) -> [Vertex] {
        return adjacencyDict[source] ?? []
    }

    func addEdge(source: Vertex, destination: Vertex) {
        adjacencyDict[source]?.append(destination)
        adjacencyDict[destination]?.append(source)
    }
}

var input = """
xq-XZ
zo-yr
CT-zo
yr-xq
yr-LD
xq-ra
np-zo
end-LD
np-LD
xq-kq
start-ra
np-kq
LO-end
start-xq
zo-ra
LO-np
XZ-start
zo-kq
LO-yr
kq-XZ
zo-LD
kq-ra
XZ-yr
LD-ws
np-end
kq-yr
"""

let inputStrings = input
    .split(separator: "\n")
    .map({ String($0) })

let splittedInputStrings = inputStrings.map({ $0.split(separator: "-").map({ String($0) }) })

var adjacencyList = AdjacencyList()

splittedInputStrings.forEach { line in
    let source = adjacencyList.createVertex(name: line[0])
    let destination = adjacencyList.createVertex(name: line[1])
    adjacencyList.addEdge(source: source, destination: destination)
}

// Part 1

var pathsCount = 0

func findAllPaths(path: [String], source: Vertex) {
    if source == "end" {
        pathsCount += 1
        return
    }
    for next in adjacencyList.adjacentVertices(source: source) {
        if next.isSmall && path.contains(next) {
            continue
        }
        findAllPaths(path: path + [next], source: next)
    }
}

findAllPaths(path: ["start"], source: "start")

print(pathsCount)

// Part 2

pathsCount = 0

func findAllPaths2(path: [String], source: Vertex, smallBeenTwice: Bool) {
    if source == "end" {
        pathsCount += 1
        return
    }
    for next in adjacencyList.adjacentVertices(source: source) {
        if next == "start" {
            continue
        }
        if next.isSmall {
            if smallBeenTwice && path.contains(next) {
                continue
            }
        }
        findAllPaths2(
            path: path + [next],
            source: next,
            smallBeenTwice: smallBeenTwice || (path.contains(next) && next.isSmall)
        )
    }
}

findAllPaths2(path: ["start"], source: "start", smallBeenTwice: false)

print(pathsCount)
