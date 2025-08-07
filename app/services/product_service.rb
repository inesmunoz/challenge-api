module ProductService
  class Create
    def initialize(params)
      @params = params
    end

    def call
      Product.create(@params)
    end
  end

  class Update
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      product = Product.find(@id)
      product.update(@params)
      product
    end
  end

  class Show
    def initialize(id)
      @id = id
    end

    def call
      Product.find(@id)
    end
  end

  class List
    def initialize(params = {})
      @params = params
    end

    def call
      Product.filtrate(@params)
    end
  end
end
