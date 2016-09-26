class NonEmptyList
  # Create a NonEmptyList instance guaranteed to contain at least one element.
  def initialize(first_element, *other_elements)
    raise "not implemented"
  end

  # Return the first element.
  def head
    raise "not implemented"
  end

  # Returns an array containing all elements except the first, in order.
  # Returns an empty array if this NonEmptyList contains only a single element.
  def tail
    raise "not implemented"
  end

  # Returns a new NonEmptyList that contains all the elements of this instance, with the given element appended.
  def append(element)
    raise "not implemented"
  end

  # Returns a new NonEmptyList that contains all the elements of this instance, with the given element prepended.
  def prepend(element)
    raise "not implemented"
  end

  # Returns a new NonEmptyList that contains all the elements of this instance, with all the given elements appended in the given order.
  def append_all(*elements)
    raise "not implemented"
  end

  # Returns a new NonEmptyList that contains all the elements of this instance, with all the given elements prepended in the given order.
  def prepend_all(*elements)
    raise "not implemented"
  end

  # Returns an array containing all the elements of this NonEmptyList in order.
  def to_a
    raise "not implemented"
  end
end
