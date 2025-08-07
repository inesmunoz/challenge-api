module ClientService
  class Create
    def initialize(params)
      @params = params
    end

    def call
      Client.create!(@params)
    end
  end

  class Update
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      client = Client.find(@id)
      client.update!(@params)
      client
    end
  end

  class Show
    def initialize(id)
      @id = id
    end

    def call
      Client.find(@id)
    end
  end

  class List
    def initialize(params = {})
      @params = params
    end

    def call
      Client.filtrate(@params)
    end
  end
end
