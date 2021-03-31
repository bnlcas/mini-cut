/// A type-erased version of Bijection.
struct AnyBijection<Input, Output>: Bijection {
    let _apply: (Input) -> Output
    let _inverseApply: (Output) -> Input
    
    init<B>(_ bijection: B) where B: Bijection, B.Input == Input, B.Output == Output {
        _apply = bijection.apply
        _inverseApply = bijection.inverseApply
    }
    
    func apply(_ value: Input) -> Output {
        _apply(value)
    }
    
    func inverseApply(_ value: Output) -> Input {
        _inverseApply(value)
    }
}
