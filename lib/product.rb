class Product

  attr_reader :title

  @@products = []

  def initialize(options ={})
   @title = options[:title]
  add_to_products
  end

  def self.all
   @@products
  end

  def self.find_by_title(title)
    @@products.find {|product| product.title == title}
    #@@products.each do |item|
    #  if item.title == "title"
    #    item.title
    #  end
    # end
  end

  private

  def add_to_products
   @@products.each do |item|
      if item.title == @title
        raise DuplicateProductError, "#{@title} already exists"
       end
     end
   @@products << self
  end
end
