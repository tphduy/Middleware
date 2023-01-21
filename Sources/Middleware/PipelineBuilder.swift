import Foundation

/// A builder that specifies methods for creating a pipeline of middlewares.
public final class PipelineBuilder<Input, Output> {
    // MARK: Subtypes

    /// An object abstracts a node in a pipeline.
    ///
    /// I hope Swift supports partial function in upcoming releases.
    struct Node {
        /// An function that provides the capabilities outside of what’s offered by the base service.
        let middleware: Middleware<Input, Output>

        /// A closure that passes control to the next middleware.
        let next: (Input) -> Output

        /// Perform the middleware function.
        /// - Parameter input: The input data for the middleware.
        /// - Returns: The processed data.
        func handle(_ input: Input) -> Output {
            middleware(input, next)
        }
    }

    // MARK: Init

    /// Initiate a builder that specifies methods for creating a pipeline of middlewares.
    public init() {}

    // MARK: Properties

    /// An array that stores the middlewares in reverse order.
    public private(set) var middlewares: [Middleware<Input, Output>] = []

    // MARK: Side Effects

    /// Insert a middleware to the pipeline.
    /// - Parameter middleware: A middleware to insert.
    /// - Returns: A builder that specifies methods for creating a pipeline of middlewares.
    @discardableResult public func use(middleware: @escaping Middleware<Input, Output>) -> Self {
        middlewares.insert(middleware, at: 0)
        return self
    }

    /// Create a closure that acts as the starting node of the pipeline.
    /// - Parameter handler: A closure that handles the finally processed data.
    /// - Returns: A closure that acts as the starting node of the pipeline.
    public func build(handler: @escaping (Input) -> Output) -> (Input) -> Output {
        middlewares.reduce(handler) { (partialResult, middleware) in
            Node(middleware: middleware, next: partialResult).handle(_:)
        }
    }
}
