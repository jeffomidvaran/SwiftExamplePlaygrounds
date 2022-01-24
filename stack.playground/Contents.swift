struct Stack<T> {
    fileprivate var array: [T] = []
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        return array.popLast()
    }
    
    func peek() -> T? {
        return array.last
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func count() -> Int {
        return array.count
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        var res = "Stack:\n"
        for e in array.reversed() {
            res += "\t\(e)\n"
        }
        return res
    }
}


var s = Stack<String>()
s.push("one")
s.pop()
s.push("two")
print(s.peek() ?? 0)
print(s)

