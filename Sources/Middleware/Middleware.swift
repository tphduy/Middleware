import Foundation

/// A function that provides the capabilities outside of what’s offered by the base service.
/// - Parameters:
///   - foo: The input data to process.
///   - bar: A closure that passes control to the next middleware.
/// - Returns: The processed data.
public typealias Middleware<Input, Output> = (
    _ input: Input,
    _ next: @escaping (Input) -> Output
) -> Output
