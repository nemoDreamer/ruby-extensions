class Array

  ##
  # wrapper for to_h
  # (prepares key/value pairs from indexes)
  def to_hash
    self.map.with_index { |v, i| [i, v] }.to_h
  end

end
