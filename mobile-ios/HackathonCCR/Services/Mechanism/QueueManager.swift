//
//  QueueManager.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 27/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

class QueueManager {
    
    // Supported queues
    public enum QueueType { case main, concurrent, serial }
    
    /// Queue used to serial operations
    private var serialQueue: OperationQueue?
    
    /// Queue used to concurrent operations
    private var concurrentQueue: OperationQueue?
    
    /// Queue manager singleton instance
    public static let sharedInstance: QueueManager = QueueManager()
    
    /// Private initializer used to create and configure internal queues
    private init() {
        // Initialize & configure serial queue
        serialQueue = OperationQueue()
        serialQueue?.maxConcurrentOperationCount = 1
        
        // Initialize & configure concurrent queue
        concurrentQueue = OperationQueue()
    }
    
    /// function responsible for executing a block of code in a particular queue
    /// - params:
    ///     - NSBlockOperation: block operation to be executed
    ///     - QueueType: queue where the operation will be executed
    public func executeBlock(_ blockOperation: BlockOperation, queueType: QueueType) {
        
        // Get queue where operation will be executed
        let queue: OperationQueue = self.getQueue(queueType)
        
        // Execute operation
        queue.addOperation(blockOperation)
    }
    
    /// function responsible for returning a specifi queue
    /// params:
    ///     - QueueType: desired queue
    /// returns: queue in according to the given param
    public func getQueue(_ queueType: QueueType) -> OperationQueue {
        
        // Queue to be returned
        var queueToBeReturned: OperationQueue?
        
        // Decide which queue
        switch queueType {
            case .concurrent:
                queueToBeReturned = self.concurrentQueue
            case .main:
                queueToBeReturned = OperationQueue.main
            case .serial:
                queueToBeReturned = self.serialQueue
        }
        
        return queueToBeReturned!
    }
}
