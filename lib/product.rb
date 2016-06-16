class Product
  @@products = []
  def initialize(options)
   options = {}
   @@products << self
  end

  def self.all
   @@products
  end
end
