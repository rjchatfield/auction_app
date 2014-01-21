class User < ActiveRecord::Base
  default_scope { order('name') }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true # case sensitive
end
