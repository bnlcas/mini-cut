/// The composition of two bijections.
struct ComposedBijection<Outer, Inner>: Bijection where Outer: Bijection, Inner: Bijection, Inner.Output == Outer.Input {
    let outer: Outer
    let inner: Inner
    
    func apply(_ value: Inner.Input) -> Outer.Output {
        outer.apply(inner.apply(value))
    }
    
    func inverseApply(_ value: Outer.Output) -> Inner.Input {
        inner.inverseApply(outer.inverseApply(value))
    }
}

extension Bijection {
    func compose<Inner>(_ inner: Inner) -> ComposedBijection<Self, Inner> {
        ComposedBijection(outer: self, inner: inner)
    }
    
    func then<Outer>(_ outer: Outer) -> ComposedBijection<Outer, Self> {
        ComposedBijection(outer: outer, inner: self)
    }
}
