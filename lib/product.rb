class Product

  attr_reader :title, :price, :stock
  attr_writer:stock # we need to be able to modify the stock attribute of given product when there is a transaction.

  @@products = [] # @@ products will help help us keep track of Product objects that will be created

  def initialize(options ={}) # we use an option hash for the arguments
   @title = options[:title]
   @price = options[:price]
   @stock = options[:stock]
   add_to_products # this method adds the new instance to the @@products array.This method is a private method
  end

  def self.all # this class method returns the @@products array
   @@products
  end

  def self.find_by_title(title) # this class method finds the instance stored in @@products with a given title
    @@products.find {|product| product.title == title}
  end

  def self.in_stock # this class method finds the product instances with a stock > 0. It uses the "in_stock?"instance method
   @@products.find_all {|product| product.in_stock? == true}
  end

  def self.available # this class method is part of a first new feature. If a transaction (see Transaction object) is made on a product which is not in stock anymore we put a message with the other products that are available
    self.in_stock.each {|item| puts "#{item.title} is still available"}
  end

  def self.include?(value) # this class method returns a boolean value when searching a product with a given title in @@products. It uses the find_by_title class method described above
    a = self.in_stock
    if a.find_by_title(value)
      return true
    else
      return false
    end
  end

  def in_stock? # this instance method evaluates if the stock for a product is > 0
    if @stock > 0
      return true
    else
      return false
    end
  end

  private

  def add_to_products # this methods inserts a new product instance in the @@products class array. We define it as a private method.
    begin
      @@products.each do |item| # this loop checks if the product already exists. If so, an error is raised with a message
        if item.title == @title
          raise DuplicateProductError, "#{@title} already exists" # see the corresponding error object DuplicateProductError. If the error is raised Ruby looks for the rescue clause
        end
      end
      @@products << self # Afer the loop is executed in case there is no error raised, the new instance is added to the @@products array
    rescue DuplicateProductError => error # the rescue clause allows the script to go on in case of error
     puts "Attention : #{error.message}"
    end
 end

end
