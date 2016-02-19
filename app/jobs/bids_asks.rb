class BidsAsks
	@queue = :bids_asks_queue
	
	def self.getNextBuyer(stockid, offset)
		return Buy.where(:stock_id => stockid).order('price DESC').limit(1).offset(offset).first
	end
	
	def self.getNextSeller(stockid, offset)
		return Sell.where(:stock_id => stockid).order('priceexpected ASC').limit(1).offset(offset).first	
	end
	
	def self.log(log)
		fname = Rails.root.join('log','buy_sell_log.log')
		somefile = File.open(fname, "a")
		time = Time.now
		somefile.puts "time::"+time.to_s+"  "+log+ "\n"
		somefile.close
   end
	
	def self.perform
		Buy.connection.clear_query_cache
		Sell.connection.clear_query_cache
		
		buy_table = Buy.uniq.pluck(:stock_id)
		sell_table = Sell.uniq.pluck(:stock_id)
		relevant_stock_ids = buy_table & sell_table		# deal with only those stocks that have both buyers and sellers
		
		BidsAsks.log(relevant_stock_ids.to_s)
		
		# go through all the stocks that've been requested for buys and sells
		relevant_stock_ids.each do |stock_id|
			Buy.connection.clear_query_cache
			Sell.connection.clear_query_cache
			
			stock_name = Stock.find_by_id(stock_id)
			
			buyer_idx = 0
			bestbuy = BidsAsks.getNextBuyer(stock_id, buyer_idx)

			until bestbuy.blank? do
				# Sell as many stocks as possible to this buyer
				
				bestbuyer = User.where(:id => bestbuy.user_id).first
				
				seller_idx = 0
				bestsell = BidsAsks.getNextSeller(stock_id, seller_idx)
				
				# buy from as many sellers as possible.
				until (bestsell.blank?) or (bestbuy.numofstock == 0) or (bestbuy.price.to_f < bestsell.priceexpected.to_f) do
				
					# don't sell someone's stocks to himself
					if bestsell.user_id == bestbuy.user_id then
						seller_idx += 1
						bestsell = BidsAsks.getNextSeller(stock_id, seller_idx)
					end
					
					bestseller = User.where(:id => bestsell.user_id).first
					seller_max_stocks = StockUsed.select("sum(stock_useds.numofstock) as totalstock").where(:user_id => bestsell.user_id, :stock_id => stock_id).first
					
					can_buy = (bestbuyer.cash.to_f / bestsell.priceexpected.to_f).floor
					can_sell = [bestsell.numofstock, seller_max_stocks.totalstock].min
					to_buy = [can_sell, can_buy, bestbuy.numofstock, bestsell.numofstock].min
					bestbuyer.cash -= to_buy * bestbuy.price
					bestseller.cash += to_buy * bestsell.priceexpected
					bestbuy.numofstock -= to_buy
					bestsell.numofstock -= to_buy
					
					StockUsed.create(:user_id => bestbuy.user_id, :stock_id => bestbuy.stock_id,:numofstock => to_buy)
					StockUsed.create(:user_id => bestsell.user_id, :stock_id => bestsell.stock_id, :numofstock => -to_buy)
					
					bestbuyer.save
					bestseller.save
					bestbuy.save
					bestsell.save
					
					Notification.create(:user_id => bestbuy.user_id, :notification => "You bought #{to_buy} stocks of #{@stock_name} at the rate of $#{bestbuy.price} per share", :seen => 1, :notice_type => 1)
					Notification.create(:user_id =>bestsell.user_id, :notification => "You sold #{to_buy} stocks of #{@stock_name} at the rate of $#{bestsell.priceexpected} per share", :seen => 1, :notice_type => 1)
					
					WebsocketRails[:buy_sell].trigger(:buy_sell_channel, "true")
					
					# exhausted the seller?
					if bestsell.numofstock == 0
						bestsell.destroy
						# don't increment seller_idx!
						bestsell = BidsAsks.getNextSeller(stock_id, seller_idx)
					end
					
				end		# end inner until loop
				
				
				if bestbuy.numofstock == 0
					# The buyer's request has been satisfied. Destroy the buy record.
					bestbuy.destroy
					# don't increment buyer_idx!
					bestbuy = BidsAsks.getNextBuyer(stock_id, buyer_idx)
				else
					# The buyer's request cannot be satisfied as of now. Keep the record
					buyer_idx += 1
					bestbuy = Buy.where(:stock_id => stock_id).order('price DESC').limit(1).offset(buyer_idx).first
				end
				
				# exhausted all sellers for this stock_id?
				if bestsell.blank? then
					break
				end
			end	# end outer until loop
		end		# relevant_stock_ids.each do |stock_id|
		
	end			# end perform()

end
