//
//  File.swift
//  
//
//  Created by Ahmed Ali on 06/11/2023.
//
// swiftlint:disable all

import Foundation
// MARK: - typed predicate types
public protocol TypedPredicateProtocol: NSPredicate { associatedtype Root }
public final class CompoundPredicate<Root>: NSCompoundPredicate, TypedPredicateProtocol {}
public final class ComparisonPredicate<Root>: NSComparisonPredicate, TypedPredicateProtocol {}

// MARK: - comparison operators
public func == <E: Equatable, R, K: KeyPath<R, E>>(kp: K, value: E) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .equalTo, value)
}
// MARK: - internal
extension ComparisonPredicate {
    convenience init<VAL>(_ kp: KeyPath<Root, VAL>, _ op: NSComparisonPredicate.Operator, _ value: Any?) {
        let ex1 = \Root.self == kp ? NSExpression.expressionForEvaluatedObject() : NSExpression(forKeyPath: kp)
        let ex2 = NSExpression(forConstantValue: value)
        self.init(leftExpression: ex1, rightExpression: ex2, modifier: .direct, type: op)
    }
}
