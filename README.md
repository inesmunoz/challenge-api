# README

API en RoR que agrupa funcionalidades de reporte sobre compras, productos y clientes asociados.

 #  Requisitos del sistema

     - Ruby 3.4.2
     - Rails ~> 8.0.2
     - PostgreSQL >= 9.6 (usa la gema pg ~> 1.1)
     - Node.js >= 16 (para Rails 8)


#  Instalación
   *Clonar el repositorio
    git clone https://github.com/inesmunoz/challenge-api.git
    cd analytics-api

   *Instalar dependencias
    bundle install

   *Configurar base de datos
    rails db:setup

# Database seeding

    Para cargar datos iniciales en la base de datos, ejecuta el siguiente comando:

    ```bash
    bin/rails db:seed

#  Endpoints principales
    La API expone los siguientes endpoints para administradores:

    | Método | Ruta                                     | Descripción                          |
    | ------ | ---------------------------------------- | ------------------------------------ |
    | GET    | `/api/v1/admin/top_purchased_products`   | Productos más comprados              |
    | GET    | `/api/v1/admin/top_revenue_products`     | Productos con mayor recaudación      |
    | GET    | `/api/v1/admin/purchases`                | Listado filtrado de compras          |
    | GET    | `/api/v1/admin/purchases_by_granularity` | Cantidad de compras por granularidad |


#  Ejecutar pruebas
    *Ejecutar todos los tests
    bundle exec rspec

    *Ver pruebas documentadas con RSwag (Swagger)
    bundle exec rake rswag

#   Documentación Swagger
    * Generar documentación
    rake rswag:specs:swaggerize

    * La ruta de acceso es:
    GET /api-docs/index.html

#  Funcionalidades principales
    ✅ Autenticación con JWT (admin-only)
    ✅ Endpoints JSON
    ✅ Filtros dinámicos con Filterable
    ✅ Agrupamiento por granularidad (day, week, month, year)
    ✅ Tests de integración y unidad con RSpec
    ✅  Documentación Swagger (RSwag)
    
# Despliegue
    *Esta API se despliega en render https://render.com/ (en construcción)

# Dependencias clave
   * jwt
   * rswag
   * rspec-rails
   * factory_bot_rails
   * database_cleaner-active_record

# Autor
    * Desarrollado por Inés Muñoz

