require 'test_helper'

class HashtagTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Hashtag::VERSION
  end
end
