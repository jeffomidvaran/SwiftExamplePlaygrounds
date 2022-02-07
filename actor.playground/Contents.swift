import UIKit

actor MyActor {
    let imutableVar = "immuatable string"
    var mutableVar: Int = 0
    func increment() async {
        mutableVar += 1
    }
    nonisolated var description: String {
        "description = \(imutableVar)"
    }
}

var myActor = MyActor()
print(myActor.imutableVar) // can access immutable vars
print(myActor.description) // can access because we set nonisolated
Task.detached {
    await myActor.increment()
    print(await myActor.mutableVar)
}

