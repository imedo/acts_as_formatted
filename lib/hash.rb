class Hash
  def without(*keys)
    inject({}) { |hash, pair| hash[pair.first] = pair.last unless keys.include?(pair.first); hash }
  end
end
