import UIKit

/*
    GCD
        thread pool
        list of work items
        one main
        4 concurrent ones
 
    Dispatch work item
        a single task
 
    QoS quality of service
        task priority
 
*/

// ##############################
// ####### TASKS FOR TESTING ####
// ##############################
func longTask() {
    var sum = 0;
    for i in 1...100000 { sum += i }
    print("long task = \(sum)")
}
func mediumTask() {
    var sum = 0;
    for i in 1...100 { sum += i }
    print("medium task = \(sum)")
}
func shortTask() {
    print("short task")
}



// ##########################################
// ########### CREATE A CUSTOM QUEUE ########
// ##########################################
let workItem = DispatchWorkItem {
    longTask()
}

let customQ = DispatchQueue(
            label: "customQueue",
            qos: .default,
            attributes: .concurrent,
            autoreleaseFrequency: .workItem // create autorease pool around block
            // target: queue // inherits attibutes from original queue
)



// ##############################
// ####### GROUP EXECUTION ######
// ##############################
let group = DispatchGroup()
customQ.async(group: group) {
    longTask()
}

customQ.async {
    mediumTask()
}

customQ.async(group:group) {
    shortTask()
}
group.wait()




// ############################################################
// LIMITING CONCURRENT TASKS TO 3 AT A TIME WITH A SEMAPHORE
// ###########################################################
let q = DispatchQueue(label: "sema q", attributes: .concurrent)
let numberOfConcurrentTasks = 3
let sema = DispatchSemaphore(value: numberOfConcurrentTasks)

for _ in 0..<6 {
    q.async {
        shortTask()
        sema.signal()
    }
    sema.wait()
}

// ##################################
// ###### REPEATED TASK #############
// ##################################
DispatchQueue.global().async {
    DispatchQueue.concurrentPerform(iterations: 10) { index in
        print("concurrent perform \(index)")
    }
}





// ###################################
// ############ MUTEX LOCK ###########
// ###################################

let lock = DispatchSemaphore(value: 1)
let q2 = DispatchQueue(label: "Mutex Lock", attributes: .concurrent)
var resouceInContention = 1

for i in 0..<6 {
    q2.async {
        lock.wait()
        resouceInContention = i
        lock.signal()
    }
    
}
