require 'json'

DEMARK = "*" * 25

def update_brand_data(brand_name, sum_retail_price, sum_purchase_price, stock, brand_data)
	if brand_data[brand_name].nil?
    brand_data[brand_name] = {count: 1, stock: stock, sum_price: sum_retail_price.to_f, sales: sum_purchase_price.to_f}
	else
    brand_data[brand_name][:count] += 1
    brand_data[brand_name][:stock] += stock
    brand_data[brand_name][:sum_price] += sum_retail_price.to_f
    brand_data[brand_name][:sales] += sum_purchase_price
	end
end

def print_report
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  products_hash = JSON.parse(file)

  brand_data = {}

  # Print "Sales Report" in ascii art
  puts %{
 ___    __    __    ____  ___    ____  ____  ____  _____  ____  ____
/ __)  /__\\  (  )  ( ___)/ __)  (  _ \\( ___)(  _ \\(  _  )(  _ \\(_  _)
\\__ \\ /(__)\\  )(__  )__) \\__ \\   )   / )__)  )___/ )(_)(  )   /  )(
(___/(__)(__)(____)(____)(___/  (_)\\_)(____)(__)  (_____)(_)\\_) (__)
  }

  # Print today's date
  puts
  puts "Report Date: " + Time.now.strftime("%m/%d/%Y")

  puts "                     _            _       "
  puts "                    | |          | |      "
  puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
  puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
  puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
  puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
  puts "| |                                       "
  puts "|_|                                       "
  puts

  # For each product in the data set:
  products_hash["items"].each do |toy|
    # Print the name of the toy
  	puts toy["title"]
  	puts DEMARK

  	# Print the retail price of the toy
  	puts "Full Price: #{toy["full-price"]}"

  	sum_purchase_price = 0
  	sum_discount = 0
  	num_purchases = 0

  	toy["purchases"].each do |purchase|
  		num_purchases += 1
  		sum_purchase_price += purchase["price"]
  		sum_discount += (purchase["price"].to_f / toy["full-price"].to_f)
  	end

  	# Calculate and print the total number of purchases
  	puts "Number of Purchases: #{num_purchases.to_s}"
  	# Calcalate and print the total amount of sales
  	puts "Total Sales Amount: $#{sum_purchase_price.to_s}"
  	# Calculate and print the average price the toy sold for
  	puts "Average Sale Price: $#{(sum_purchase_price / num_purchases).to_s}"
  	# Calculate and print the average discount based off the average sales price
  	puts "Average Discount Percent: #{((sum_discount / num_purchases) * 100).round(2).to_s}%"
  	puts

  	update_brand_data toy["brand"], toy["full-price"], sum_purchase_price, toy["stock"], brand_data

  end

  puts " _                         _     "
  puts "| |                       | |    "
  puts "| |__  _ __ __ _ _ __   __| |___ "
  puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
  puts "| |_) | | | (_| | | | | (_| \\__ \\"
  puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
  puts

  # For each brand in the data set:
  brand_data.each do |brand_name, data|
      # Print the name of the brand
  		puts brand_name
  		puts DEMARK
      # Count and print the number of the brand's toys we stock
  		puts "Number of Products: #{data[:count].to_s}"
      # Calculate and print the average price of the brand's toys
  		puts "Average Retail Price: $#{(data[:sum_price] / data[:count]).round(2).to_s}"
      # Calculate and print the total sales volume of all the brand's toys combined
  		puts "Total Sales Volume: $#{data[:sales].round(2).to_s}"
  		puts
  end
end
