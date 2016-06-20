class Customer

  attr_reader :name

  @@customers = []

  def self.all
   @@customers
  end

  def initialize (options = {})
    @name = options[:name]
    add_to_customers
  end

  def self.find_by_name(name)
    @@customers.find {|customer| customer.name == name}
    #@@products.each do |item|
    #  if item.title == title
    #    item.title
    #  end
    # end
  end

  private

  def add_to_customers
   @@customers.each do |item|
      if item.name == @name
        raise DuplicateProductError, "#{name} already exists"
       end
     end
   @@customers << self
  end

end
