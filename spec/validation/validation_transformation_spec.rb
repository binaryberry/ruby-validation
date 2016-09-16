require 'nel/non_empty_list'
require 'validation/validation'

RSpec.describe Validation do
  it "should transform success value with fold" do
    v = Validation.success("yay")
    l = v.fold(lambda { fail "shouldn't need to call this" }, lambda { |s| s.length });

    expect(l).to be 3
  end

  it "should transform failure value with fold" do
    v = Validation.failure("boo", "oh noes")
    l = v.fold(lambda { |errors| errors.length }, lambda { fail "shouldn't need to call this" });

    expect(l).to be 2
  end

  it "should transform success with map" do
    v = Validation.success("yay")
    l = v.map(lambda { |s| s.length });

    expect(l).to be_success_of(3)
  end

  it "should not transform failure with map" do
    v = Validation.failure("boo")
    l = v.map(lambda { fail "shouldn't need to call this" });

    expect(l).to be_failure_of("boo")
  end

  it "should transform success with flat_map" do
    v = Validation.success("yay")
    l = v.flat_map(lambda { |s| Validation.success(s.length) });
    f = v.flat_map(lambda { |s| Validation.failure("boo") });

    expect(l).to be_success_of(3)
    expect(f).to be_failure_of("boo")
  end

  it "should not transform failure with flat_map" do
    v = Validation.failure("boo")
    l = v.flat_map(lambda { fail "shouldn't need to call this" });

    expect(l).to be_failure_of("boo")
  end
end
