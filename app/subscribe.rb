class Subscribe
  attr_reader :subscribers

  def initialize
  	@subscribers = load
  end

  def add(id, period: '1d')
    return if exists?(id)
  	@subscribers[id] = period
    save
    SubscribeSchedule.new.add(id, period)
    true
  end

  def remove(id)
    return unless exists?(id)
    @subscribers.delete(id)
    save
    SubscribeSchedule.new.remove(id)
  end

  def exists?(id)
    @subscribers.keys.include? id
  end

  private

  def save
    File.write(ENV['SUBSCRIBERS'], YAML.dump(@subscribers))
  end

  def load
  	File.exists?(ENV['SUBSCRIBERS']) ? YAML.load_file(ENV['SUBSCRIBERS'])  : {}
  end
end