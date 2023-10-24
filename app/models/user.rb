class User < ApplicationRecord
  
  has_secure_password

  validates :username, 
    uniqueness: true, 
    length: { in: 3..30 }, 
    format: { without: URI::MailTo::EMAIL_REGEXP, message:  "can't be an email" }
  validates :email, 
    uniqueness: true, 
    length: { in: 3..255 }, 
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { in: 6..255 }, allow_nil: true

    before_validation :ensure_session_token

    def self.find_by_credentials(credential, password)
      if credential.match?(URI::MailTo::EMAIL_REGEXP)
        user = find_by(email: credential)
     else
        user = find_by(username: credential)
      end
      return nil unless user

      # Use the authenticate method to check the password
      if user.authenticate(password)
        return user # Return the user if the password is correct
      else
        return nil # Return nil if the password is incorrect
      end

    end 

    def reset_session_token!
    self.session_token = generate_unique_session_token
    save!
    self.session_token

    end
    

    private

     def exists?(random_token)

      User.where(session_token: random_token).exists?
    
      # return User.find_by( session_token: random_token) 
      
     end 

    # def generate_unique_session_token

    #   random_token = SecureRandom.base64(64)

    #  if 
    #   User.exists?(random_token) 
    #    generate_unique_session_token() 
    #  else 
    #   return random_token  
    #  end 
     def generate_unique_session_token
      loop do
        random_token = SecureRandom.hex(64)
        break random_token unless self.class.exists?(session_token: random_token)
      end

    end


    def ensure_session_token
      self.session_token ||= generate_unique_session_token()
    end

   
end

