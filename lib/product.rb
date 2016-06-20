class Product

  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options ={})
   @title = options[:title]
   @price = options[:price]
   @stock = options[:stock]
  add_to_products
  end

  def self.all
   @@products
  end

  def self.find_by_title(title)
    @@products.find {|product| product.title == title}
    #@@products.each do |item|
    #  if item.title == title
    #    item.title
    #  end
    # end
  end

  def self.in_stock
   @@products.find_all {|product| product.in_stock? == true}
  end

  def self.include?(value)
    a = self.in_stock
    if a.find_by_title(value)
      return true
    else
      return false
    end
  end

  def in_stock?
    if @stock > 0
      return true
    else
      return false
    end
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
