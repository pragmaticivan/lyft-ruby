module Lyft
  # Rides API
  class Rides < APIResource
    def rides(options = {})
      path = rides_path
      get(path, options)
    end

    private ##############################################################

    def rides_path
      path = "/rides"
    end
  end
end
