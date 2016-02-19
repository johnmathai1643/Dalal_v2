class Bank < ActiveRecord::Base
    
    belongs_to :stocks
	has_many :users

	def self.mortgage_to_bank(stock, num_of_stock, cur_user)
		@stockid = stock.id
		@numofstock_to_mortgage = num_of_stock
		@success = "nyo"
		
		@check_stock = Stock.joins(:stock_useds).select("stocks.*,sum(stock_useds.numofstock) as totalstock").where('stock_useds.user_id' => cur_user.id,'stocks.id' => @stockid ).group("stock_id").first
		
		if @check_stock.nil?
			stockname = stock.stockname
			@error = "You don't own any stocks of #{stockname}"
			Notification.create(:user_id => cur_user.id, :notification => @error, :seen => 1, :notice_type => 2)
			raise @error
		end
        
		if @check_stock.totalstock.to_f >= @numofstock_to_mortgage.to_f and @numofstock_to_mortgage.to_f>0
			@user_cash_inhand = User.find(cur_user.id)
			@user_cash_inhand.cash = @user_cash_inhand.cash.to_f + 0.75*@numofstock_to_mortgage.to_f*@check_stock.currentprice.to_f
			@stockused = StockUsed.create(:user_id => cur_user.id, :stock_id => @stockid,:numofstock => -1*@numofstock_to_mortgage.to_f)
			@mortgage = Bank.create(:user_id => cur_user.id, :stock_id => @stockid, :pricerendered => @check_stock.currentprice, :numofstock => @numofstock_to_mortgage)
			@user_cash_inhand.save  
			@extra_cash = 0.75*@numofstock_to_mortgage.to_f*@check_stock.currentprice.to_f
			@extra_cash = @extra_cash.round(2)
			@success = "Mortgage Successful. $#{@extra_cash} added to your account"
			@notification = Notification.create(:user_id =>cur_user.id, :notification => @success, :seen => 1, :notice_type => 1)
			@user_total_calculator = User.calculate_total(cur_user.id)
		else
			@error = "Invalid request.You only have #{@check_stock.totalstock} stocks of #{@check_stock.stockname}."
			@notification = Notification.create(:user_id =>cur_user.id, :notification => @error, :seen => 1, :notice_type => 2)
			raise @error
		end

		return @success
	end
	
	def self.return_from_bank(mortgage_id, cur_user)
		logger.info "bankreturn_" + mortgage_id
		################## check mortgage again ######################################################
		@id = mortgage_id
		@mortgage = Bank.where("banks.user_id" => cur_user.id,"banks.id" => @id).first
		if(@mortgage.nil?)
			raise "The mortgage record you request to return doesn't exist."
		end
		
		@success = ""
		
		@user = User.find(cur_user.id)
		@stock = Stock.select("currentprice").where('stocks.id' => @mortgage.stock_id).first
		#### u can just modifify that that record #####
		@stockused = StockUsed.create(:user_id => cur_user.id, :stock_id => @mortgage.stock_id,:numofstock => @mortgage.numofstock)
		
		if @user.cash > @mortgage.numofstock.to_f*@stock.currentprice.to_f
			@user.cash = @user.cash - @mortgage.numofstock.to_f*@stock.currentprice.to_f
			@deducted = (@mortgage.numofstock.to_f*@stock.currentprice).round(2)
			if @user.save
				@mortgage.destroy
				@success = "$#{@deducted} deducted from your account,stocks retrieved from bank."
				@notification = Notification.create(:user_id =>cur_user.id, :notification => @success, :seen => 1, :notice_type => 1)
				@user_total_calculator = User.calculate_total(cur_user.id)
			else
				@error = "Error processing request.Please try again."
				@notification = Notification.create(:user_id =>current_user.id, :notification => @error, :seen => 1, :notice_type => 3)
				raise @error
			end
		else
			@error = "You have only $#{@user.cash} in your account.You cannot retrieve your stocks."
			@notification = Notification.create(:user_id =>current_user.id, :notification => @error, :seen => 1, :notice_type => 2)
			raise @error
		end  
		
		return @success
	end
end
