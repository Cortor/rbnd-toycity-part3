class Transaction

  attr_reader :customer, :product, :id, :buy

  @@id = 1 #  this class variable helps the Transaction class know the total number of transactions
  @@transactions = [] # this arrays holds the transaction objects that have been created

  def initialize(customer,product, buy = true) # the Transaction object is created with 3 arguments. The buy argument has a default value to true. True is for a purchase, false for a return
    @id = @@id
    @customer = customer
    @product = product
    @buy = buy
    update_stock(product)
    add_transaction
  #  add_transaction
  #  @@id = @@id + 1 # @@id class variable is incremented by one at the end of the instantiation
  end

  def update_stock(product) # method to updtate the stock value of a product from a Transaction object. The stock decreases by 1 for a purchase and increases by one for a product return
    begin
      if buy == true # tests if the transaction is a purchase
        if product.in_stock? # test for assessing the availability of the product
          product.stock -=1 # for a purchase, the stock decreases by 1
        else
        raise OutOfStockError, "#{product.title} is out of stock" # if the product is not available, a specific "OutOfStockError" is raised
      end
      else # test if the transaction is a product return
       product.stock +=1 # for a product return, the stock increases by 1
      end
##  @@id=@@id+1 ## @@@id is incremented by 1 in 2 cases : when the transaction is a purchase and the stock is >0 and when the transaction is a product return. If the transaction is a purchase and the stock == 0 an error is raised and @@id is not incremented
    rescue => error # the rescue clause allows the script to go on in case of error
      puts "Attention #{error.message}"
      Product.available # when the product is not available this method puts the product(s) with a stock > 0
    end
  end

  def increment
    @@id = @@id+1
  end

  def transactions_push
    @@transactions << self
  end

  def self.all # this class method returns the @@transactions array
    @@transactions
  end

  def self.compteur
    @@id
  end

  def self.find(id) # this class method finds the instance stored in @@transaction with a given id
    @@transactions.find {|transaction| transaction.id == id}
  end

#private
  def add_transaction # this methods inserts a new transaction instance in the @@transaction class array. We define it as a private method.
    unless buy == true and product.in_stock? == false # this condition avoids to create a transaction in  the @@transactions array when this a purchase and the product is not available.
      transactions_push
      increment # @@id is incremented only when there is no sale problem linked to a zero stock
    end
  end

end
