require 'nel/non_empty_list'
require 'validation/validation'
require_relative 'matchers/matchers'

RSpec.describe Validation do
  it "should apply function in validation to success validation" do
    v = Validation.success("yay")
    f = Validation.success(lambda { |s| s.length })

    expect(v.apply(f)).to be_success_of(3)
    expect(v.apply(Validation.failure("boo"))).to be_failure_of("boo")
  end

  it "should apply function in validation to failure validation" do
    v = Validation.failure("boo")

    expect(v.apply(Validation.success(lambda { fail "shouldn't need to call this" }))).to be_failure_of("boo")
    expect(v.apply(Validation.failure("oh noes", "not again"))).to be_failure_of("boo", "oh noes", "not again")
  end

#
# Before moving on, examine your implementation of apply(). What does it achieve?
# Can you implement Validation.apply() in a single function, without overriding it for success or failure? If not, consider refactoring until you can.
# You will probably need some confidence with apply() to use it in the remaining tasks, and performing this refactoring might make its structure clearer.
#

  it "should sequence list of success validations" do
    vs = [Validation.success("a"), Validation.success("b"), Validation.success("c")]
    sequenced = Validation.sequence(vs)

    expect(sequenced).to be_success_of(["a", "b", "c"])
  end

  it "should sequence list with failure validations" do
    vs = [Validation.failure("boo"), Validation.success("b"), Validation.failure("oh noes", "not again")]
    sequenced = Validation.sequence(vs)

    expect(sequenced).to be_failure_of("boo", "oh noes", "not again")
  end

  it "should traverse list of success validations" do
    vs = [Validation.success("a"), Validation.success("bb"), Validation.success("ccc")]
    traversed = Validation.traverse(vs) { |s| s.length }

    expect(traversed).to be_success_of([1, 2, 3])
  end

  it "should traverse list with failure validations" do
    vs = [Validation.failure("boo"), Validation.success("b"), Validation.failure("oh noes", "not again")]
    traversed = Validation.traverse(vs) { fail "shouldn't need to call this" }

    expect(traversed).to be_failure_of("boo", "oh noes", "not again")
  end

  it "should transform several successful validations with mapN" do
    vs = [Validation.success("woo"), Validation.success(2), Validation.success("yay")]
    transformed = Validation.mapN(vs) { |a, b, c| "#{a} #{b} #{c}" }

    expect(transformed).to be_success_of("woo 2 yay")
  end

  it "should transform several validations with failures with mapN" do
    vs = [Validation.failure("boo"), Validation.success(2), Validation.failure("oh noes", "not again"), Validation.success("yay")]
    transformed = Validation.mapN(vs) { fail "shouldn't need to call this" }

    expect(transformed).to be_failure_of("boo", "oh noes", "not again")
  end
end
