//
//  FindPath.swift
//  comfort
//
//  Created by Алиев Дмитрий on 15/06/2018.
//  Copyright © 2018 Алиев Дмитрий. All rights reserved.
//

import Foundation

struct Coordinates {
    let x: Int
    let y: Int
}

extension Coordinates: Hashable, Equatable {
    var hashValue: Int { return (Int) (y * 100 + x) }
    
    public static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

}

enum Point: Character {
    case toilet = "t"
    case lift = "l"
    case kitchen = "k"
    case football = "f"
    case coffee = "c"
    case razdevalra = "r"
    case visited = "v"
    case wall = "0"
    case spase = "1"
    case start = "s"
}

class PathFinder {
    func findPath(from: Coordinates, to: Point) -> [Coordinates]? {
        let maze1 = netString.replacingOccurrences(of: "\n", with: "")
        
        var maze: [Point] = maze1.map { return Point(rawValue: $0)! }

        var frontier = [Coordinates]()
        frontier.append(from)
        var cameFrom = [Coordinates: Coordinates]()
        
        while !frontier.isEmpty {
            let current = frontier.removeFirst()
            print("\(current.y) \(current.x)")
            print(maze[current.y * 100 + current.x])
//            print("\n")
            if maze[current.y * 100 + current.x] == to {
                var pathPoint = current
                var result: [Coordinates] = []

                while true {
                    guard let point = cameFrom[pathPoint] else {
                        break
                    }
                    pathPoint = point
                    result.append(pathPoint)
                }
                return result
            }
            for neighbor in neighbors(current) {
                if maze[neighbor.y * 100 + neighbor.x] == to || maze[neighbor.y * 100 + neighbor.x] == .spase {
                    frontier.append(neighbor)
                    cameFrom[neighbor] = current
                }
            }
            maze[current.y * 100 + current.x] = .visited
        }
        
        return nil //no path
    }

    func findTropa(from: Coordinates) -> [Coordinates]? {
        let to = Point.spase
        let maze1 = netString.replacingOccurrences(of: "\n", with: "")
        
        var maze: [Point] = maze1.map { return Point(rawValue: $0)! }
        
        var frontier = [Coordinates]()
        frontier.append(from)
        var cameFrom = [Coordinates: Coordinates]()
        
        while !frontier.isEmpty {
            let current = frontier.removeFirst()
            print("\(current.y) \(current.x)")
            print(maze[current.y * 100 + current.x])
            //            print("\n")
            if maze[current.y * 100 + current.x] == to {
                var pathPoint = current
                var result: [Coordinates] = [current]
                
                while true {
                    guard let point = cameFrom[pathPoint] else {
                        break
                    }
                    pathPoint = point
                    result.append(pathPoint)
                }
                return result
            }
            for neighbor in neighbors(current) {
                if maze[neighbor.y * 100 + neighbor.x] != .visited {
                    frontier.append(neighbor)
                    cameFrom[neighbor] = current
                }
            }
            maze[current.y * 100 + current.x] = .visited
        }
        
        return nil //no path
    }

    private func neighbors(_ point: Coordinates) -> [Coordinates] {
        var result = [Coordinates]()
        result.append(Coordinates(x: point.x - 1, y: point.y))
        result.append(Coordinates(x: point.x + 1, y: point.y))
        result.append(Coordinates(x: point.x, y: point.y + 1))
        result.append(Coordinates(x: point.x, y: point.y - 1))
        return result.filter({ (point) -> Bool in
            point.y < 50 && point.y >= 0 && point.x < 100 && point.x >= 0
        })
    }
//    func findPath(from: Coordinates, to: Point, currentPath: [Coordinates]) -> [Coordinates]? {
//
//        let maze1 = netString.replacingOccurrences(of: "\n", with: "")
//        let maze: [Point] = maze1.map { Point(rawValue: $0)! }
//
//        var path: [Coordinates] = []
//
//        let bot = Coordinates(x: from.x, y: from.y + 1)
//        switch maze[bot.y * 50 + bot.x] {
//        case to:
//            return currentPath + path
//        case .spase:
//            path.append(bot)
//            return findPath(from: bot, to: to, currentPath: path)
//        default: break
//        }
//
//
//
//        return nil //no path
//    }
}
