module CategoryService
  class Create
    def initialize(params)
      @params = params
    end

    def call
      Category.create!(@params)
    end
  end

  class Update
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      category = Category.find(@id)
      category.update!(@params)
      category
    end
  end

  class Show
    def initialize(id)
      @id = id
    end

    def call
      Category.find(@id)
    end
  end

  class List
    def initialize(params = {})
      @params = params
    end

    def call
      Category.filtrate(@params)
    end
  end
end
