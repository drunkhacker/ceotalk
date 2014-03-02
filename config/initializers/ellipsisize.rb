class String
  def truncate_center(target_length=16)
    return self if self.length <= target_length
    p_len = (target_length - 2)/2

    head = self[0...p_len]
    tail = self[self.length-p_len-1...-1]

    "#{head}...#{tail}"
  end

  def ellipsisize(minimum_length=4,edge_length=3)
    return self if self.length < minimum_length or self.length <= edge_length*2 
    edge = '.'*edge_length    
    mid_length = self.length - edge_length*2
    gsub(/(#{edge}).{#{mid_length},}(#{edge})/, '\1...\2')
  end
end

