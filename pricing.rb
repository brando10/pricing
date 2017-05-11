class Plan
  def self.options
    header = ["Product Code", "Product Name", "Price"]
    sub = { "ult_small" => "Unlimited 1GB", "ult_medium" => "Unlimited 2GB",
            "ult_Large" => "Unlimited 5GB", "1GB" => "1 GB Data Pack"}
    puts "#{header[0]} - #{header[1]} - #{header[2]}"
    puts "#{sub.to_a[0][0]} - #{sub.to_a[0][1]} - $24.90"
    puts "#{sub.to_a[1][0]} - #{sub.to_a[1][1]} - $29.90"
    puts "#{sub.to_a[2][0]} - #{sub.to_a[2][1]} - $44.90"
    puts "#{sub.to_a[3][0]} - #{sub.to_a[3][1]} - $9.90"
  end

  def self.choose(name)
    print "Please choose product code of your choice:"
    puts " "
    print "ult_small | ult_medium | ult_Large | 1GB"
    Util.lb
    print "Input here: "
    codie = gets
    cp = codie.chomp
    self.choose_cond(cp, name)
  end

  def self.choose_cond(cp, name)
    Util.cart_header(name)
    case cp.downcase
    when "ult_small" then puts "Ult Small for $24.90"
    when "ult_medium" then puts "Ult Medium for $29.90"
    when "ult_large" then puts "Ult Large for $44.90"
    when "1gb" then puts "1GB for $9.90"
    else
      Util.lb
      Util.spacer_one
      puts "wrong input"
      Util.spacer_one
      Util.lb
      self.choose(name)
    end
    Util.spacer_one
    self.quantity(cp, name)
  end

  def self.quantity(cp, name)
    print "How many #{cp} would you like to purchase (max quantity 5): "
    qua = gets.chomp
    quaqua = qua.to_i
    if quaqua > 5
      puts "Exceeds maximum quantity of purchase"
      Util.spacer_one
      self.quantity(cp, name)
    else
      if cp.eql?("1gb") && quaqua.eql?(3)
        Util.cart_header(name)
        Util.lb
        Util.spacer_one
        puts "Bulk discount 3 for 2 deal for the first month!"
        Util.spacer_one
        Util.lb
        puts "Current_total: $19.8"
        total = "$19.8"
        Util.spacer_one
        self.choose_two(cp, name, quaqua, present=true, total)
      elsif cp.eql?("ult_large") && quaqua > 3
        Util.cart_header(name)
        gig = 39.90 * quaqua
        puts "#{cp} quantity: #{quaqua}"
        puts "Current_total: $#{gig}"
        Util.lb
        Util.spacer_one
        puts "Bulk Discount applied! $39.90 for the first month for more than 3 purchase!"
        Util.spacer_one
        Util.lb
        self.choose_two(cp, name, quaqua, present=true, gig)
      elsif cp.eql?("ult_medium")
        pp = Util.matcher(cp) * quaqua
        Util.cart_header(name)
        puts "#{cp} quantity: #{quaqua}"
        puts "Current_total: $#{pp}"
        Util.spacer_one
        Util.lb
        puts "Congratulations! free 1 GB Data-Pack Free of charge!"
        Util.lb
        Util.spacer_one
        self.choose_two(cp, name, quaqua, present=true, pp)
      else
        current_total = Util.matcher(cp) * quaqua
        Util.cart_header(name)
        puts "#{cp} quantity: #{quaqua}"
        puts "Current_total: $#{current_total}"
        Util.spacer_one
        self.choose_two(cp, name, quaqua, present=false, current_total)
      end
    end
  end

  def self.choose_two(cp, name, quaqua, present, total)
    puts "Were almost complete!"
    puts "A: Checkout"
    puts "B: Purchase More"
    puts "C: Exit"
    print "Please choose from the menu: "
    ch2 = gets.chomp
    chtwo = ch2.downcase
    Util.spacer_one
    self.verify(cp, name, quaqua, chtwo, present, total, 0)
  end

  def self.verify(cp, name, quaqua, chtwo, present, total, second)
    if present.eql?(true)
      trips = total
    else
      trips = Util.matcher(cp) * quaqua
    end

    case chtwo
    when "a" then self.checkout(cp, name, quaqua, chtwo, present, total)
    when "b" then self.more(cp, name, quaqua, chtwo, present, total)
    when "c" then puts "Thank you Good Bye!!!"
    else
    end
  end

  def self.checkout(cp, name, quaqua, chtwo, present, total)
    self.promo_codie(cp, name, quaqua, chtwo, present, total)
  end

  def self.more(cp, name, quaqua, chtwo, present, total)
    self.choose_new(cp, name, quaqua, chtwo, present, total)
  end

  def self.choose_new(cp, name, quaqua, chtwo, present, total)
    Util.lb
    Util.spacer_one
    puts "Great! #{name}"
    puts "Current Cart: #{cp} - Quantity: #{quaqua}"
    Util.spacer_one
    Util.lb
    print "Please choose another product code of your choice:"
    puts " "
    print "ult_small | ult_medium | ult_Large | 1GB"
    Util.lb
    print "Input here: "
    prep = gets
    tp = prep.chomp
    self.choose_cond_new(cp, name, quaqua, chtwo, present, total, tp)
  end

  def self.choose_cond_new(cp, name, quaqua, chtwo, present, total, second)
    Util.cart_header(name)
    case second.downcase
    when "ult_small" then puts "Ult Small for $24.90"
    when "ult_medium" then puts "Ult Medium for $29.90"
    when "ult_large" then puts "Ult Large for $44.90"
    when "1gb" then puts "1GB for $9.90"
    else
      Util.lb
      Util.spacer_one
      puts "wrong input"
      Util.spacer_one
      Util.lb
      self.choose(name)
    end
    Util.spacer_one
    self.choose_two_new(cp, name, quaqua, chtwo, present, total, second)
  end


  def self.choose_two_new(cp, name, quaqua, chtwo, present, total, second)
    puts "Were almost complete!"
    puts "A: Checkout"
    puts "C: Exit"
    print "Please choose from the menu: "
    ch2 = gets.chomp
    chtwo = ch2.downcase
    Util.spacer_one
    self.verify(cp, name, quaqua, chtwo, present, total, second)
  end

  def self.promo_codie(cp, name, quaqua, chtwo, present, total)
    Util.lb
    print "Please enter your promo code(leave blank if none): "
    pcode = gets.chomp
    Util.lb
    if pcode.eql?("I<3AMAYSIM")
      Util.lb
      Util.spacer_one
      puts "Congratulations! Promo code validated successfully!!!"
      puts "10% discount!"
      Util.spacer_one
      Util.lb
      codecode = Util.matcher(cp) * quaqua
      till = codecode * 0.10
      bill = total - till
      Util.spacer_one
      puts "Thank you #{name}"
      puts "#{cp} quantity: #{quaqua}"
      puts "10 percent discount applied."
      puts "Current_total: $#{bill}"
      Util.lb
      Util.spacer_one
      puts "Thank you for your purchase! An email confirmation will be sent."
      puts "We have charged your credit/debit card amounting to #{bill} Dollars Thank you!"
    elsif pcode.eql?(" ")
      puts "Thank you for your purchase! An email confirmation will be sent."
    else
      puts "Thank you for your purchase! An email confirmation will be sent."
      puts "We have charged your credit/debit card amounting to #{total} Dollars Thank you!"
    end
  end
end

class Util
  def self.welcome
    self.spacer_one
    puts "Hi Welcome to My Telco"
    puts "Please login:"
    self.spacer_one
  end

  def self.auth
    print "Username: "
    user_name = gets
    print "Password: "
    password = gets
    Util.spacer_one
    puts "Authenticated Successfully!"
    Util.spacer_one
    puts "Welcome #{user_name}!"
    Plan.options
    Util.lb
    Plan.choose(user_name)
  end

  def self.cart_header(name)
    puts "Thanks #{name}! Here is your initial cart load"
    puts "Your cart: "
  end

  def self.matcher(cp)
    case cp
    when "ult_small" then 24.90
    when "ult_medium" then 29.90
    when "ult_large" then 44.90
    when "1gb" then 9.90
    else
    end
  end

  def self.spacer_one
    1.times do
      puts "<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>"
    end
  end

  def self.lb
    2.times do
      puts " "
    end
  end
end

Util.welcome
Util.auth
