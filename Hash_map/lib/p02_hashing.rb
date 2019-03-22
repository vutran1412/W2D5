class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      result += el.hash ^ idx
    end
    result
  end
end

class String
  def hash
    result = length
    chars = self.split('')
    chars.each_with_index do |ch, idx|
      new_ch = (ch.ord * idx).hash
      
      result += new_ch
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys
    values = self.values
    result =  keys.hash + values.hash
    result
  end
end
