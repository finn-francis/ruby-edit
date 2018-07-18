# frozen_string_literal: true

class String
  def titleize
    tr('_', ' ').capitalize
  end
end

