class Validation
  def initialize
    raise "You can't instantiate Validation directly, use `success()` or `failure()` instead. Please don't modify or extend Validation yourself."
  end

  # factory methods

  def self.success(value)
    raise "not implemented"
  end

  def self.failure(error, *other_errors)
    raise "not implemented"
  end

  # interface below here

  def is_success?
    raise "not implemented"
  end

  def is_failure?
    raise "not implemented"
  end
  
  def get_or_else(default_value)
    raise "not implemented"
  end

  def or_else(default_validation)
    raise "not implemented"
  end

  def fold(if_failure, if_success)
    raise "not implemented"
  end

  def map(&if_success)
    raise "not implemented"
  end

  def flat_map(&if_success)
    raise "not implemented"
  end

  def apply(applicable_validation)
    raise "not implemented"
  end

  def self.sequence(validations)
    raise "not implemented"
  end

  def self.traverse(validations, &block)
    raise "not implemented"
  end

  def self.mapN(validations, &block)
    raise "not implemented"
  end
end
