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

puts "⏳ Creando categorías..."
category1 = Category.find_or_create_by!(name: "Electrónica")
category2 = Category.find_or_create_by!(name: "Hogar")
category3 = Category.find_or_create_by!(name: "Ropa")
puts "✅ Categorías creadas."

puts "⏳ Creando productos..."
product1 = Product.find_or_create_by!(name: "Smartphone", description: "Teléfono inteligente", price: 350.99, product_type: "PhysicalProduct")
product2 = Product.find_or_create_by!(name: "Laptop", description: "Computadora portátil", price: 1200.50, product_type: "PhysicalProduct")
product3 = Product.find_or_create_by!(name: "E-book", description: "Libro digital", price: 9.99, product_type: "DigitalProduct")
puts "✅ Productos creados."

puts "⏳ Asociar productos a categorías..."
Categorization.find_or_create_by!(product: product1, category: category1)
Categorization.find_or_create_by!(product: product2, category: category1)
Categorization.find_or_create_by!(product: product2, category: category2)
Categorization.find_or_create_by!(product: product3, category: category3)
puts "✅ Asociaciones creadas."

puts "⏳ Creando clientes..."
client1 = Client.find_or_create_by!(name: "Juan Pérez", email: "juan@example.com")
client2 = Client.find_or_create_by!(name: "Ana Gómez", email: "ana@example.com")
puts "✅ Clientes creados."

# Create images for products (assuming you use Active Storage)
# If you want to use sample files, put images in /db/seeds/images and load them with:
# product1.images.create!(file: File.open(Rails.root.join("db/seeds/images/smartphone.jpg")))
# product2.images.create!(file: File.open(Rails.root.join("db/seeds/images/laptop.jpg")))

puts "⏳ Creando compras..."
Purchase.find_or_create_by!(client: client1, product: product1, quantity: 1, total_price: product1.price)
Purchase.find_or_create_by!(client: client1, product: product3, quantity: 2, total_price: product3.price * 2)
Purchase.find_or_create_by!(client: client2, product: product2, quantity: 1, total_price: product2.price)
puts "✅ Compras creados."
