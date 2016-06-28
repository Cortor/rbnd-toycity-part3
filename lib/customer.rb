class Customer

  attr_reader :name

  @@customers = [] # @@customer will help help us keep track of Customer objects that will be created

  def initialize (options = {}) # we use an option hash for the arguments
    @name = options[:name]
    add_to_customers
  end

  def purchase(product, buy = true) # method to instanciate a new Transaction object from a Customer object
    Transaction.new(@name,product, buy)
  end

  def self.all # this class method returns the @@customer array
   @@customers
  end

  def self.find_by_name(name) # this class method finds the instance stored in @@customers with a given name
    @@customers.find {|customer| customer.name == name}
  end

  private

  def add_to_customers # this methods inserts a new customer instance in the @@customers class array. We define it as a private method.
    begin
      @@customers.each do |item| # this loop checks if the customers already exists. If so, an error is raised with a message
        if item.name == @name
          raise DuplicateCustomerError, "#{name} already exists" # see the corresponding error object
        end
      end
      @@customers << self # adds the customer instance the @@customers array
    rescue DuplicateCustomerError => error # the rescue clause allows the script to go on in case of error
      puts "Attention : #{error.message}. He will not be created twice !"
    end
  end

end
