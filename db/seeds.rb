puts "⏳ Creando roles..."

admin_role = Role.find_or_create_by!(name: "administrador")
cashier_role = Role.find_or_create_by!(name: "cajera")

puts "✅ Roles creados."

puts "⏳ Creando usuarios..."

User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "123456"
  user.role = admin_role
end

User.find_or_create_by!(email: "cajera@example.com") do |user|
  user.password = "123456"
  user.role = cashier_role
end

puts "✅ Usuarios creados:"
puts "- admin@example.com / 123456 (administrador)"
puts "- cajera@example.com / 123456 (cajera)"
