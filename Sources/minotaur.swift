import LogicKit

let zero = Value (0)

func succ (_ of: Term) -> Map {
    return ["succ": of]
}

func toNat (_ n : Int) -> Term {
    var result : Term = zero
    for _ in 1...n {
        result = succ (result)
    }
    return result
}


struct Position : Equatable, CustomStringConvertible {
    let x : Int
    let y : Int

    var description: String {
        return "\(self.x):\(self.y)"
    }

    static func ==(lhs: Position, rhs: Position) -> Bool {
      return lhs.x == rhs.x && lhs.y == rhs.y
    }

}

func room (_ x: Int, _ y: Int) -> Term {
  return Value (Position (x: x, y: y))
}

func doors (from: Term, to: Term) -> Goal {
  return
    (from === room(2, 1) && to === room(1, 1)) ||
    (from === room(3, 1) && to === room(2, 1)) ||
    (from === room(4, 1) && to === room(3, 1)) ||
    (from === room(1, 2) && to === room(1, 1)) ||
    (from === room(1, 2) && to === room(2, 2)) ||
    (from === room(2, 2) && to === room(3, 2)) ||
    (from === room(3, 2) && to === room(3, 3)) ||
    (from === room(3, 2) && to === room(4, 2)) ||
    (from === room(4, 2) && to === room(4, 1)) ||
    (from === room(4, 2) && to === room(4, 3)) ||
    (from === room(1, 3) && to === room(1, 2)) ||
    (from === room(2, 3) && to === room(1, 3)) ||
    (from === room(2, 3) && to === room(2, 2)) ||
    (from === room(1, 4) && to === room(1, 3)) ||
    (from === room(2, 4) && to === room(2, 3)) ||
    (from === room(3, 4) && to === room(3, 3)) ||
    (from === room(3, 4) && to === room(2, 4)) ||
    (from === room(4, 4) && to === room(3, 4))
}

func entrance (location: Term) -> Goal {
    return (location === room(4,1)) || (location === room(4,4))
}

func exit (location: Term) -> Goal {
    return (location === room(1,1)) || (location === room(3,4))
}

func minotaur (location: Term) -> Goal {
    return (location === room(2,3))
}

func path (from: Term, to: Term, through: Term) -> Goal {
  return (from === to && through === List.cons(from, List.empty)) ||
      delayed (fresh { begin in fresh { rest_list in fresh { end in
        (through === List.cons(from, rest_list)) &&
        (rest_list === List.cons(begin, end)) &&
        (doors(from : from, to : begin)) &&
        (path(from : begin, to : to, through : rest_list)) }}})
}




func MinotorInThrough (_ path: Term) -> Goal {
  return
    delayed ( fresh {
      x in fresh {
        y in
          (path === List.cons(y, x)) &&
          (minotaur(location : y) ||
          MinotorInThrough(x))
      }
    }
  )
}

func isNat (_ n : Term) -> Goal {
  return (n === zero) ||
  delayed (fresh {
    x in
      (n === succ(x) && isNat(x))
    }
  )
}
func battery (through: Term, level: Term) -> Goal {
  return ((through === List.empty) &&
    (isNat(level))) ||
    delayed (fresh { x in fresh { y in fresh { z in
    (level === succ(y) &&
    through === List.cons(z as Term, x) &&
  battery (through : x, level : y)) }}})
}

func winning (through: Term, level: Term) -> Goal {
  return
    battery(through : through, level : level) &&
    MinotorInThrough(through) &&
    fresh {
    x in fresh {
    y in
    (entrance(location : x) &&
    exit(location : y) &&
    path(from : x, to : y, through : through))}}
}
