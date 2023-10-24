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

    private

     def exists?(random_token)
    
      return User.find_by( session_token: random_token) 
      
     end 

    def generate_unique_session_token

      random_token = SecureRandom.base64(64)

      print "I am generating" + random_token

     if 
      User.exists?(random_token) 
       generate_unique_session_token() 
     else 
      return random_token  
     end 

     

    end


    def ensure_session_token
      self.session_token ||= generate_unique_session_token()
    end

   
end
