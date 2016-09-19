identity = lambda { |x| x }

RSpec::Matchers.define :be_success_of do |expected|
  match do |actual|
    actual.is_success? && actual.fold(nil, identity) == expected
  end
end

RSpec::Matchers.define :be_failure_of do |*expected|
  match do |actual|
    errs = actual.fold(identity, nil)
    actual.is_failure? && actual.fold(identity, nil) == expected
  end
end
