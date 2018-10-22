# frozen_string_literal: true

# Extension of the string class
#
# Contains any methods that the string class is 'missing'
class String
  # Turns snakecase into normal text e.g.
  #
  ## 'i_am_a_sentence'.titleize == 'I am a sentence'
  ## => 'I am a sentence'
  def titleize
    tr('_', ' ').capitalize
  end
end

