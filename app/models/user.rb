class User < ApplicationRecord
    has_many :sessions
    has_many :tasks

    # validations
    validates :username, presence: true, length: { minimum: 3, maximum: 20 }
    validates :password, presence: true, length: { minimum: 8, maximum: 20 }
    validates_uniqueness_of :username

    # hash password before saving to database
    before_create :hash_password

    private 
    # hash password using BCrypt
    def hash_password
        self.password = BCrypt::Password.create(self.password)
    end
end
