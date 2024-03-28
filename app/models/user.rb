class User < ApplicationRecord
    has_many :sessions

    # validations
    validates :username, presence: true, length: { minimum: 3, maximum: 20 }
    validates :password, presence: true, length: { minimum: 8, maximum: 20 }
    validates_uniqueness_of :username
end
