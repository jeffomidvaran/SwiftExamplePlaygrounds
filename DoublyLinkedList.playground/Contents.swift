import UIKit


public class Node<T> {
    var value: T
    var next: Node?
    /*
     make a one of the pointers weak to
     avoid a strong reference cycle
    */
    weak var previous: Node?

    init(value: T) {
        self.value = value
    }
}

public class DoublyLinkedList<T>{
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    
    // GET ONLY PROPERTIES
    public var isEmpty: Bool {
        return self.head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
       return tail
    }
    
    public func append(value:T) {
        let newNode = Node(value: value)
        if let tailNode = tail {
            // there are nodes in the linked list
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    public func getNode(atIndex i: Int) -> Node<T>? {
        if i >= 0 {
            var node = head
            var count = i
            while node != nil {
                if(count == 0) {
                    return node
                }
                count -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public func removeNode(node: Node<T>) -> T? {
        // remove 1st node
        // remove middle node
        // remove last node
        /*
            1 -> 2 -> 3 -> 4 -> nil
               w    w   w
            H
         */
        
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    
}


extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var node = head
        var res = "["
        while node != nil {
            res += "\(node!.value)"
            node = node!.next
            if node != nil {
                res += ", "
            }
        }
        return res + "]"
    }
}



let dogBreeds = DoublyLinkedList<String>()
dogBreeds.append(value: "Labrador")
dogBreeds.append(value: "Bulldog")
dogBreeds.append(value: "Beagle")
dogBreeds.append(value: "Husky")

print(dogBreeds)



