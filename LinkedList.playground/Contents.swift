
class Node<T: Comparable> {
    public var value: T
    public var next: Node?
    init(value: T) {
        self.value = value
    }
}


class LinkedList<T: Comparable> {
    private var head: Node<T>?
    public var count = 0
    public var first: Node<T>? {
        return head
    }
    public var isEmpty: Bool  {
        return head == nil
    }
    
    public func addNode(value: T) {
        let newNode = Node(value: value)
        count += 1
        
        if(head == nil) {
            head = newNode
            return
        }
        
        var pos = head
        while(pos != nil) {
            if(pos!.next == nil) {
                pos!.next = newNode
                return
            }
            pos = pos!.next
        }
    }
    
    public func removeNode(value: T) {
        if(head == nil) {
            return
        }
        var pos = head
        var prevPos: Node<T>? = nil
        while(pos != nil) {
            /*
             // head
             // end
             // middle
              1 -> 2 -> 3 -> nil
             */
            if(pos!.value == value) { // at front
                if(prevPos == nil) {
                    head = head!.next
                } else if(pos!.next == nil) { // at end
                    prevPos!.next = nil
                } else { // found at middle
                    prevPos!.next = pos!.next
                }
                count -= 1
                // ensure there are no strong reference cycles
                pos = nil
                prevPos = nil
                return
            }
            prevPos = pos
            pos = pos!.next
        }
    }
}


extension LinkedList: CustomStringConvertible {
    var description: String {
        var res = "["
        var node = head
        while(node != nil) {
            res += "\(node!.value)"
            node = node!.next
            if(node != nil) {
                res += ", "
            }
        }
        return res + "]" + " count: \(self.count)"
    }
}


var ll = LinkedList<Int>()
ll.addNode(value: 1)
ll.addNode(value: 2)
ll.addNode(value: 3)
ll.removeNode(value: 10)
print(ll)

