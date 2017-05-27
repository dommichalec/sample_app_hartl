require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
   @admin     = users(:dom)
   @non_admin = users(:archer)
  end
end
