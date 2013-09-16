# encoding: UTF-8
require 'openssl'
require 'base64'

class User < ActiveRecord::Base
    has_many :activities
    has_many :authentications
    has_many :products
    #acts_as_cached
    mount_uploader :avatar, AvatarUploader

    attr_accessor :password, :password_confirmation, :current_password,:terms_of_service

    validates_presence_of     :email                           
    validates_presence_of     :nickname                        
    validates_presence_of     :password                       
    validates_length_of       :password, within: 4..40     
    validates_confirmation_of :password                        
    validates_presence_of     :password_confirmation  
    validates_length_of       :current_password, within: 4..40   , if: :require_current_password?    
    validates_length_of       :email, within: 5..100  
    validates_uniqueness_of   :email, case_sensitive: false
    validates_format_of       :email, with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i 

    validates :terms_of_service, acceptance: true
    #Auth
    def self.authenticate(email, password)
        #binding.pry
        user = first(conditions: {email: email}) if email.present? && password.present?
        user && user.password_match?(password) ? user : nil
    end

    #Role
    def admin?
        self.id == 1
    end

    def saler?
        self.role == 1
    end

    def role_description
        admin? ? "管理员" : saler? ? "团长":"团员"
    end    

    #action
    def save_when_create
        self.password_digest = ::BCrypt::Password.create(password)
        save
    end

    def update_password
        #binding.pry
        if current_password.present? && self.password_match?(current_password)
            self.password_digest = ::BCrypt::Password.create(password)
            save!
        else
            return false
        end 
    end

    def reset_password
        self.password_digest = ::BCrypt::Password.create(password)
        update_column(:password_digest, self.password_digest) 
    end
    #Cookie
    def encrypt_cookie_value
        cipher = OpenSSL::Cipher::AES.new(256, :CBC)
        cipher.encrypt
        cipher.key = APP_CONFIG['session_secret']
        Base64.encode64(cipher.update("#{id} #{password_digest}") + cipher.final)
    end

    def self.decrypt_cookie_value(encrypted_value)
        decipher = OpenSSL::Chiper::AES.new(256, :CBC)
        decipher.decrypt
        decipher.key = APP_CONFIG['session_secret']
        plain = decipher.update(Base64.decode64(encrypted_value)) + decipher.final
        id, password_digest = plain.split
        return id.to_i, password_digest
    rescue
        return 0, ""
    end

    def self.validate_cookie(encrypt_value)
        user_id, password_digest = decrypt_cookie_value(encrypt_value)
        user_id != 0 && user = find(user_id) && user.password_digest == password_digest ? user : nil 
    end

    #
    def password_match?(user_input_password)
        ::BCrypt::Password.new(password_digest) == user_input_password
    end

    def has_avatar?
        self.read_attribute(:avatar).present?
    end
    
    private
    def encrypt_password
        self.password_digest = ::BCrypt::Password.create(password)
    end

    def require_current_password?
        current_password.present?
    end
end
