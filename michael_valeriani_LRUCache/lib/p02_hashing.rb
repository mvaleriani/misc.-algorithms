
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 0
    self.each_with_index do |el, idx|
      hashed += (el.hash*idx.hash)
    end
    hashed
  end
end

class String
  def hash
    hashed = 0
    self.chars.each_with_index do |char, idx|
      hashed += (char.ord.hash * idx.hash)
    end
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    self.each do |key, value|
      hashed += key.hash * value.hash
    end
    hashed
  end
end
