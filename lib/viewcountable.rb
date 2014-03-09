module ViewCountable
  def increase_view_count!
    self.increment! :view_count
  end
end
