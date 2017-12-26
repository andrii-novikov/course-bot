module Figaro
  class Application
    private

    def default_path
      "config/application.yml"
    end

    def default_environment
      ENV['ENV'] || 'development'
    end
  end
end
