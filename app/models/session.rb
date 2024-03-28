class Session < ApplicationRecord
    belongs_to :user

    # generate token for new session
    before_validation :generate_session_token


    private

    def generate_session_token
        #urlsafe_base64 generates a random URL-safe base64 string
        self.token = SecureRandom.urlsafe_base64
    end
end
