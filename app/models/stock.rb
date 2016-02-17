class Stock < ActiveRecord::Base
      # validates :currentprice, presence: true
      
has_many :stock_useds
has_many :banks

	def self.buy_stuff(id, stock_bought, num, current_user)
		@success = 0
		@numofstock = num
		@stockidbought = id

		logger.info num

		@stock_bought = Stock.find(@stockidbought)

		if @stock_bought.stocksinexchange >= @numofstock and @numofstock > 0 and @numofstock <= 10
			@total_price_of_bought_stock = @numofstock*@stock_bought.currentprice
			@user_cash_inhand = User.find(current_user.id)
			if @user_cash_inhand.cash - @total_price_of_bought_stock > 0
				@user_cash_inhand.cash = @user_cash_inhand.cash-@total_price_of_bought_stock
				@stock_bought.stocksinexchange = @stock_bought.stocksinexchange - @numofstock
				@stock_bought.stocksinmarket = @stock_bought.stocksinmarket + @numofstock
				@stock_bought.save
				@user_cash_inhand.save
				@user_total_calculator = User.calculate_total(current_user.id)
				@stockused = StockUsed.create(:user_id => current_user.id, :stock_id => @stockidbought,:numofstock => @numofstock)
				notice = "#{@numofstock} stocks of #{@stock_bought.stockname} traded successfully"
				Notification.create(:user_id =>current_user.id, :notification => notice, :seen => 1, :notice_type => 1)
				@success = notice
			else
				err = "Not Enough Cash to trade #{@numofstock} stocks of #{@stock_bought.stockname}. You can get cash by mortgaging stocks at the Bank."
				Notification.create(:user_id =>current_user.id, :notification => err, :seen => 1, :notice_type => 2)
				raise err
				end
		else
			if @numofstock > 10
				err = "You cannot trade more than 10 stocks at a time. Trade failed."
				Notification.create(:user_id =>current_user.id, :notification => err, :seen => 1, :notice_type => 3)
				raise err
			else
				err = "Invalid trade parameters. Please check and try again."
				Notification.create(:user_id =>current_user.id, :notification => err, :seen => 1, :notice_type => 3)
				raise err
			end
		end      

		return @success
	end
	
	def self.bid_stuff(current_user, stock_id, num_of_stocks, price)
	  puts current_user.id
		if !num_of_stocks.blank? && !price.blank?
		  @stockid = stock_id
		  @numofstock_buy_for = num_of_stocks
		  @bid_price = price
		  @bid_price = @bid_price.to_f.round(2);
		  @stock = Stock.find(@stockid) 
		  @user_cash_inhand = User.find(current_user.id)
		 
		  if @stock.stocksinmarket.to_f >= @numofstock_buy_for.to_f
		   if @bid_price >= (@stock.currentprice.to_f-0.1*@stock.currentprice.to_f)
		     if @user_cash_inhand.cash.to_f >= @numofstock_buy_for.to_f*@bid_price.to_f 
		      @buy_bid = Buy.create(:user_id=>current_user.id, :stock_id=>@stockid, :price=>@bid_price, :numofstock=>@numofstock_buy_for)
		      @notice = "Successful Bid."
		      #flash[:error] =nil
		      @notification = Notification.create(:user_id =>current_user.id, :notification => @notice, :seen => 1, :notice_type => 1)
		      @comparator = User.comparator("buy")
		      @user_total_calculator = User.calculate_total(current_user.id)
		      #buy_sell_stock_socket_helper
		     else
		      #flash[:notice]=nil
		      error = "Buy request failed.You only have $ #{@user_cash_inhand.cash}."
		      @notification = Notification.create(:user_id =>current_user.id, :notification => @error, :seen => 1, :notice_type => 2)
		      raise error
		      #buy_sell_stock_socket_helper
		     end
		   else
		    #flash[:notice]=nil
		    @min_bid_price = (@stock.currentprice.to_f-0.1*@stock.currentprice.to_f).round(2)
		    error = "You cannot bid for less than 10% of the current price the minimum buy price for #{@stock.stockname} is #{@min_bid_price}."
		    @notification = Notification.create(:user_id =>current_user.id, :notification => error, :seen => 1, :notice_type => 2)
		    raise error
		    #buy_sell_stock_socket_helper   
		   end  
		  else
		   #flash[:notice]=nil
		   error = "Buy request failed.There are only #{@stock.stocksinmarket} stocks in the market."
		   @notification = Notification.create(:user_id =>current_user.id, :notification => error, :seen => 1, :notice_type => 2)
		   raise error
		   #buy_sell_stock_socket_helper
		  end
		else
		  #flash[:notice]=nil
		  error = "You have encountered an unexpected error. Please login and Try again."
		  raise error
		  #redirect_to :action => 'index'
		end 
  	end



 def self.get_total_stock_price(id) 
   @stocks = Stock.joins(:stock_useds).select("sum(stock_useds.numofstock)*stocks.currentprice as netcash").where('stock_useds.user_id' => id).group("stock_id")
   @price_of_tot_stock = 0

   if !@stocks.blank?
      @stocks.each do |stock| 
        @price_of_tot_stock = @price_of_tot_stock.to_f + stock.netcash.to_f
      end
      return @price_of_tot_stock.round(2)
   else
      return 0
   end   
 end

 def self.return_bought_stocks(id)
   @stocks = Stock.joins(:stock_useds).select("stocks.*,sum(stock_useds.numofstock) as totalstock,sum(stock_useds.numofstock)*stocks.currentprice as netcash").where('stock_useds.user_id' => id).group("stock_id")
   return @stocks
 end

 def self.return_stock_user_first(user)
   @stock = Stock.joins(:stock_useds).select("stocks.*,sum(stock_useds.numofstock) as totalstock,sum(stock_useds.numofstock)*stocks.currentprice as netcash").where('stock_useds.user_id' => user).group("stock_id").first
   if @stock.blank?
     return nil
   else
     return @stock
   end
 end

 def self.individual_statistics(id)
    @stock = Stock.select("*").where(:id => id).first
      if @stock.daylow.to_f > @stock.currentprice.to_f
         @stock.daylow = @stock.currentprice.to_f
      end
      if @stock.dayhigh.to_f < @stock.currentprice.to_f
         @stock.dayhigh = @stock.currentprice.to_f
      end      
      if @stock.alltimehigh.to_f < @stock.dayhigh.to_f
         @stock.alltimehigh = @stock.dayhigh.to_f
      end
      if @stock.alltimelow.to_f > @stock.daylow.to_f
         @stock.alltimelow = @stock.daylow.to_f
      end
      @stock.save
  end

 def self.update_current_price(id,price)
     file_name = Rails.root.join('app','chart-data',id.to_s+'.log')
     if file_name.exist?
      file = File.open(file_name, "a")
     else
      file = File.new(file_name, "w+")
     end
     file.print price.round(2).to_s+","
     @update_stats = Stock.individual_statistics(id) 
     file.close
 end

 def self.read_current_price(id)
	  file_name = Rails.root.join('app','chart-data',id.to_s+'.log')
    if file_name.exist?
     file = File.open(file_name, "rb")
     price_list = file.read
     file.close
  	else 
     file = File.new(file_name, "w+")
     @stock = Stock.select(:currentprice).where(:id => id).first
     file.print @stock.currentprice.round(2).to_s+","
     file.close
    end
   	return price_list.to_s
 end

end
