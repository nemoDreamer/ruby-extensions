class Hash

  ##
  # @return [Integer] Length of largest value
  def breadth
    (self.values.max_by { |v| v.length }).length
  end

end
