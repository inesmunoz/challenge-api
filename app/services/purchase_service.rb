module PurchaseService
  class Create
    def initialize(params)
      @params = params
    end

    def call
      Purchase.create!(@params)
    end
  end

  class Update
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      purchase = Purchase.find(@id)
      purchase.update!(@params)
      purchase
    end
  end

  class Show
    def initialize(id)
      @id = id
    end

    def call
      Purchase.find(@id)
    end
  end

  class List
    def initialize(params = {})
      @params = params
    end

    def call
      Purchase.filtrate(@params)
    end
  end
end
