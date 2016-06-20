class Customer

  attr_reader :name

  @@customers = []

  def self.all
   @@customers
  end

  def initialize (name)
    @name = name
    @@customers << self
  end
end
