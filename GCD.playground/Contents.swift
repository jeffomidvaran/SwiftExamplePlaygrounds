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

// #####################################
// ############ MUTEX LOCK 1 ###########
// #####################################
func task1() {
    print("task 1")
    sleep(1)
    print("after task 1")
}

func task2() {
    print("task 2")
    sleep(2)
    print("after task 2")
}
var s = DispatchSemaphore(value: 1)
DispatchQueue.global().async {
    s.wait()
    task1()
    s.signal()
}

DispatchQueue.global().async {
    s.wait()
    task2()
    s.signal()
}



// #####################################
// ############ MUTEX LOCK 2 ###########
// #####################################

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


// ##################################################################
// ############ RETURNING THE RESULTS OF A           ################
// ############ LONG RUNNING TASK TO THE MAIN QUEUE  ################
// ##################################################################

DispatchQueue.global(qos: .userInitiated).async {
    // get long results of long running task
    DispatchQueue.main.async {
        // update main queue with results
    }
}


// #######################################
// ############ DeadLock #################
// #######################################

/*
    sync stops current queue execution until the closure is finished
    main thread is already running synchronus tasks so calling sync will interupt the current synchronus task (causing the program to crash
*/
//DispatchQueue.main.sync {}



/*
 the async closure needs to reach the end of it execution before it can be added to the queue
 when sync start it takes control so async can't finish
 sync's task can't run until async is set to thread to run
 
*/

let serialQueue = DispatchQueue(label: "testing")
serialQueue.async {
    longTask()
    serialQueue.sync {
        shortTask()
    }
}
