class ApiController < ActionController::Base
	include SocketHelper
	include ApiHelper
	before_filter :check_credentials!
	
	def index
		public_channels = WebsocketRails.channel_manager.channels.values.reject(&:is_private?).map(&:name)
	  render json: public_channels
#		render :text => "Hello " + @cur_user.username + " :)"
	end
	
	def get_market_events
		skip = params[:skip] || 0
		limit = params[:limit] || 20
		company_name = params[:company]
		if(company_name != nil) then
			stock = Stock.where('stockname' => company_name).first
			@market_events_paginate = MarketEvent.order('created_at DESC').where('stock_id' => stock.id).limit(limit).offset(skip)
		else
			@market_events_paginate = MarketEvent.order('created_at DESC').limit(limit).offset(skip)		
		end
		
		@market_events_total = MarketEvent.count
		
		render :json => {
			market_events_total: @market_events_total,
			market_events_list: @market_events_paginate
		}
	end
	
	def get_stocks
		Stock.connection.clear_query_cache
		@stocks_list = Stock.all
		@price_of_tot_stock = Stock.get_total_stock_price(@cur_user.id)
		User.calculate_total(@cur_user.id)
		@user_current_cash = @cur_user.cash.round(2)
		
		render :json => {
			stocks_list: @stocks_list,
			price_of_tot_stock: @price_of_tot_stock,
			user_current_cash: @user_current_cash,
			user_total_calculator: @cur_user.total
		}
	end
	
	def get_notifications
		skip = params[:skip] || 0
		limit = params[:limit] || 10
		@notifications_list = Notification.select("notification,updated_at,id").where('user_id' => @cur_user.id).order('created_at DESC').limit(limit).offset(skip)
		
		render :json => {
			notifications_list: @notifications_list
		}
	end
	
	def get_leaderboard
		page = params[:page] || 1
		if(page < 1) then 
			page = 1 
		end
		
		limit = params[:limit] || 30
		@user_leader = User.paginate(:page => page,:per_page => limit).order('total DESC')
		
		render :json => {
			leaderboard: @user_leader
		}
	end
	
	def get_bids_and_asks
		skip = params[:skip] || 0
		limit = params[:limit] || 10
		stocks = Stock.all.group_by(&:id)
		
		@buy_history = Buy.select("id,stock_id,numofstock,updated_at,price").where('user_id' => @cur_user.id).order('updated_at DESC').limit(limit).offset(skip)
		
		buys = []
		@buy_history.each do |buy|
			buys.push({
				:message => "Bid for " + buy.numofstock.to_s + " stocks of " + stocks[buy.stock_id][0].stockname + " at $" + buy.price.to_s + " per share",
				:time => buy.updated_at
			})
		end
        
		@sell_history = Sell.select("id,stock_id,numofstock,updated_at,priceexpected").where('user_id' => @cur_user.id).order('updated_at DESC').limit(limit).offset(skip)
		
		sells = []
		@sell_history.each do |sell|
			sells.push({
				:message => "Ask for " + sell.numofstock.to_s + " stocks of " + stocks[sell.stock_id][0].stockname + " at $" + sell.priceexpected.to_s + " per share",
				:time => sell.updated_at
			})
		end
		
		render :json => {
			bids: buys,
			asks: sells
		}
	end
	
	def get_home
		skip = params[:skip] || 0
		limit = params[:limit] || 20		
		company_name = params[:company]
		if(company_name != nil) then
			stock = Stock.where('stockname' => company_name).first
			@market_events_paginate = MarketEvent.order('created_at DESC').where('stock_id' => stock.id).limit(limit).offset(skip)
		else
			@market_events_paginate = MarketEvent.order('created_at DESC').limit(limit).offset(skip)		
		end
		
		@market_events_total = MarketEvent.count

		Stock.connection.clear_query_cache
		@stocks_list = Stock.all
		@price_of_tot_stock = Stock.get_total_stock_price(@cur_user.id)
		User.calculate_total(@cur_user.id)
		@user_current_cash = @cur_user.cash.round(2)
		
		render :json => {
			price_of_tot_stock: @price_of_tot_stock,
			user_current_cash: @user_current_cash,
			user_total_calculator: @cur_user.total,
			market_events_total: @market_events_total,
			stocks_list: @stocks_list,
			market_events_list: @market_events_paginate
		}
	end
	
	def get_mortgage
		stockname = params[:stockname]
		
		if stockname.blank?
			render :json => {
				success: "false",
				message: "stockname is a required parameter"
			}
			return
		end
		id = Stock.find_by_stockname(stockname).id
		@stock = Stock.joins(:stock_useds).select("stocks.*,sum(stock_useds.numofstock) as totalstock").where('stock_useds.user_id' => @cur_user.id,'stock_useds.stock_id' => id).group("stock_id").first
		@mortgage = Stock.joins(:banks).select("*,banks.numofstock*stocks.currentprice as netcash").where("banks.user_id" => @cur_user.id,"banks.stock_id" => id)
		
		render :json => {
			success: "true",
			mortgage: @mortgage
		}
	end
	
	
	def post_buy_stocks
		@success = 0
		@numofstock = params[:value]
		@stockidbought = params[:identity]
		@numofstock = @numofstock.to_f ##convert to integer
		
		@notice = nil
		@error = nil
       
	    if @stockidbought && @numofstock
	    	@stocktobuy = Stock.where(:id => @stockidbought).first
	        begin
		       @success = Stock.buy_stuff(@stockidbought, @stocktobuy, @numofstock.to_f, @cur_user)
		       if(@success) then
		        	@notice = @success
		       end
		    rescue => msg
		    	@error = msg.message
		    end
	    else
	        @error = "Bad API Call. 'value' and 'identity' expected."
	        @notification = Notification.create(:user_id =>@cur_user.id, :notification => @error, :seen => 1, :notice_type => 3) 
	    end ##main if block 1
	    
	    if @notice then
	    	render :json => {
	    		success: "true",
	    		message: @notice
	    	}
	    	@stockall = Stock.all
            api_stock_ajax_handler_helper(@stockall, @cur_user)
	    else
	    	render :json => {
	    		success: "false",
	    		message: @error
	    	}
	   	end
	end
	
	
	def post_mortgage_to_bank
		@success = nil
		@error = nil
		
		if !params[:stock_id].blank? and !params[:num_of_stock].blank?
			@stockid = params[:stock_id]
			@numofstock_to_mortgage = params[:num_of_stock]
			begin
				@success = Bank.mortgage_to_bank @stockid, @numofstock_to_mortgage, @cur_user
			rescue => msg
				@error = msg.message
			end
		else
			@error = "Bad API call"
		end
		
		if !@success.nil? then
			render :json => {
				success: "true",
				message: @success
			}
			
			api_bank_mortgage_socket_helper(@cur_user)
		else
			render :json => {
				success: "false",
				message: @error
			}
		end
	end
	
	
	def post_mortgage_return_from_bank
		@success = nil
		@error = nil
		
		if !params[:mortgage_id].blank?
			@id = params[:mortgage_id]
			
			begin
				@success = Bank.return_from_bank @id, @cur_user
			rescue => msg
				@error = msg.message
			end
			
			api_bank_mortgage_socket_helper(@cur_user)
		else
			@error = "Bad API Call"
		end
		
		if @success then
			render :json => {
				success: "true",
				message: @success
			}
			
			api_bank_mortgage_socket_helper(@cur_user)
		else
			render :json => {
				success: "false",
				message: @error
			}
		end
	end
end
