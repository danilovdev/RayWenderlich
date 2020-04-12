
import Foundation

class AsyncOperation: Operation {
    
    // Since the state of an operation is read-only, you’ll first want to give yourself a way to
    // track changes in a read-write manner
    enum State: String {
        case ready
        case executing
        case finished
        
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    
    // By default, your state is ready.
    var state: State = .ready {
        // Because you need to send the appropriate KVO notifications when you change
        // the value, you’ll attach property observers to the property.
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    // It’s critical that you include a check to the base class' isReady method
    // as your code isn’t aware of everything that goes on while the scheduler
    // determines whether or not it is ready to find your operation a thread to use.
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    // specify that you are in fact using an asynchronous operation.
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        // Make possible for your operation to be canceled before it’s started.
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
}

class AsyncSumOperation: AsyncOperation {
  let rhs: Int
  let lhs: Int
  var result: Int?

  init(lhs: Int, rhs: Int) {
    self.lhs = lhs
    self.rhs = rhs

    super.init()
  }

  override func main() {
    DispatchQueue.global().async {
      Thread.sleep(forTimeInterval: 2)
      self.result = self.lhs + self.rhs
      self.state = .finished
    }
  }
}

let queue = OperationQueue()
let pairs = [(2, 3), (5, 3), (1, 7), (12, 34), (99, 99)]

pairs.forEach { pair in
  let op = AsyncSumOperation(lhs: pair.0, rhs: pair.1)
  op.completionBlock = {
    guard let result = op.result else { return }
    print("\(pair.0) + \(pair.1) = \(result)")
  }

  queue.addOperation(op)
}

queue.waitUntilAllOperationsAreFinished()

