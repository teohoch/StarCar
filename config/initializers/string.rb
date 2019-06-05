class String
  def number?
    true if Float(self)
  rescue StandardError
    false
  end
end
