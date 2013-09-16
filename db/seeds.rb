#create admin user
puts "===================create admin user"
user = User.new(id: 1,email: "admin@admin.com", nickname: "admin", password: "admin", password_confirmation: "admin")
user.save_when_create