import UIKit

/*
 OPERATION Objects
     built on top of GCD
    single synchronous task
    execution starts as soon as possible
 
 OPERATION STATES
     Ready: It’s prepared to start
     Executing: The task is currently running
     Finished: Once the process is completed
     Canceled: The task canceled
 
 operation can only be executed once
     operations gone once they are in Finished or cancelled
*/


// #######################################
// ###### CREATE blocks for testing ######
// #######################################
let fastBlock = BlockOperation {
    print("fast Block")
}

let mediumBlock = BlockOperation {
    sleep(1)
    print("medium Block")
}

let slowBlock = BlockOperation {
    sleep(2)
    print("slow Block")
}

// #########################################
// ######### BLOCK ON COMPLETION ###########
// #########################################
// RUNS WHEN FASTBLOCK IS COMPLETED
fastBlock.completionBlock = {
    print("Fast Block complete")
}


// #############################################
// ######### CREATE QUEUE / ADD OPERATIONS #####
// #############################################
let queue = OperationQueue()
queue.name = "myQueue" //  for debugging
queue.maxConcurrentOperationCount = 3

queue.addOperation(mediumBlock)
queue.addOperations([fastBlock, slowBlock], waitUntilFinished: true)

