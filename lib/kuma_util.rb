module Kuma
    class Util
        def self.encrypted_password(password)
            ::BCrypt::Password.create(password)
        end
    end
end