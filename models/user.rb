class User < OmniAuth::Identity::Models::ActiveRecord
    has_many :activities
    has_many :authentications

    validates_presence_of :email, :nickname
    validates_uniqueness_of :email
    validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
end
