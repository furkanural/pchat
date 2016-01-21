class Conversation < ApplicationRecord
  belongs_to :starter, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages
  has_secure_token

  validates_length_of :pin, :minimum => 5, :maximum => 5

end
