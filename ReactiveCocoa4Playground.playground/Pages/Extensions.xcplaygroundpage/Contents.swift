//: Playground - noun: a place where people can play

import UIKit
import ReactiveCocoa

extension SignalType {
    public func catchReplace(replace: T) -> Signal<T, NoError> {
        return Signal { observer in
            return self.observe { event in
                switch event {
                case .Error(_):
                    sendNext(observer, replace)
                    sendCompleted(observer)
                case .Completed: sendCompleted(observer)
                case .Interrupted: sendInterrupted(observer)
                case .Next(let value): sendNext(observer, value)
                }
            }
        }
    }
}

extension SignalProducerType {
    public func catchReplace(replace: T) -> SignalProducer<T, NoError> {
        return lift { $0.catchReplace(replace) }
    }
}

