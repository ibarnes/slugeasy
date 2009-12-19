require 'test_helper'

class PostTest < ActiveSupport::PostCase
  def test_should_be_valid
    assert Post.new.valid?
  end
end
