import Foundation


struct Coordinate: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

let direction: [Character: Set<Coordinate>] = [
    "K": [
        Coordinate(-2, -1), Coordinate(-1, -2), Coordinate(1, -2), Coordinate(2, -1),
        Coordinate(2, 1), Coordinate(1, 2), Coordinate(-1, 2), Coordinate(-2, 1)
    ],
    "G": [
        Coordinate(-1, -1), Coordinate(0, -1), Coordinate(1, -1), Coordinate(1, 0),
        Coordinate(1, 1), Coordinate(0, 1), Coordinate(-1, 1), Coordinate(-1, 0)
    ]
]

func step() -> Int {
    var buff: [(pos: (Int, Int), status: Character)] = [(start, "K")]
    
    var res = 0
    while !buff.isEmpty {
        res += 1
        for _ in 0..<buff.count {
            let (pos, status) = buff.removeFirst()
            
            let currentI = pos.0
            let currentJ = pos.1
            
            for direction in direction[status]! {
                let i = currentI + direction.x
                let j = currentJ + direction.y
                
                if (i, j) == end {
                    return res
                } else if (0 <= i && i < n) && (0 <= j && j < n) && !visited[status]!.contains(Coordinate(i, j)) {
                    if board[i][j] != "." && board[i][j] != "S" {
                        buff.append(((i, j), board[i][j]))
                        visited[status]!.insert(Coordinate(i, j))
                    } else {
                        buff.append(((i, j), status))
                        visited[status]!.insert(Coordinate(i, j))
                    }
                }
            }
        }
    }
    return -1
}

let n = Int(readLine()!)!
var board = [[Character]]()
var start = (-1, -1)
var end = (-1, -1)

for i in 0..<n {
    let row = Array(readLine()!)
    if let startIndex = row.firstIndex(of: "S") {
        start = (i, startIndex)
    } else if let endIndex = row.firstIndex(of: "F") {
        end = (i, endIndex)
    }
    board.append(row)
}

var visited: [Character: Set<Coordinate>] = [
    "K": [Coordinate(start.0, start.1)],
    "G": []
]

let result = step()
print(result)
