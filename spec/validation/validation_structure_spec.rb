require 'nel/non_empty_list'
require 'validation/validation'

RSpec.describe Validation do
  it "should hint that it shouldn't be extended" do
    expect { Validation.new }.to raise_error RuntimeError
  end

  it "should provide a factory method for success values" do
    v = Validation.success("yay")

    expect(v.is_success?).to be true
    expect(v.is_failure?).to be false
  end

  it "should provide a factory method for failure values" do
    v = Validation.failure("boo")

    expect(v.is_success?).to be false
    expect(v.is_failure?).to be true

    v = Validation.failure("boo", "oh noes")

    expect(v.is_success?).to be false
    expect(v.is_failure?).to be true
  end

  it "should fail when factory methods are called with invalid parameters" do
    expect { Validation.success }.to raise_error ArgumentError
    expect { Validation.success(nil) }.to raise_error RuntimeError
    expect { Validation.success("a", "b") }.to raise_error ArgumentError

    expect { Validation.failure }.to raise_error ArgumentError
    expect { Validation.failure(nil) }.to raise_error RuntimeError
    expect { Validation.failure("a", nil, "b") }.to raise_error RuntimeError
  end

  it "should retrieve success value from success" do
    value = "yay"
    v = Validation.success(value)
    retrieved_value = v.get_or_else(lambda { fail "shouldn't need to call this" })
    expect(retrieved_value).to be value
  end

  it "should retrieve default value from failure" do
    default_value = "foo"
    v = Validation.failure("boo")
    retrieved_value = v.get_or_else(lambda { default_value })
    expect(retrieved_value).to be default_value
  end

  it "should retrieve self from success validation" do
    v = Validation.success("yay")
    retrieved_validation = v.or_else(lambda { fail "shouldn't need to call this" })
    expect(retrieved_validation).to be v
  end

  it "should retrieve default validation from failure validation" do
    default_validation = Validation.success("foo")
    v = Validation.failure("boo")
    retrieved_validation = v.or_else(lambda { default_validation })
    expect(retrieved_validation).to be default_validation
  end
end
