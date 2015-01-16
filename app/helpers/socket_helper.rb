module SocketHelper
   @partials = nil;
   
   #print and returns list of all bound partials
   def show_partials
      hash = {partials: @partials, inputs: @sessions};
      puts("Current Partials: " + hash.to_s);
      return hash;
   end
   
   #Build a hash mapping each html element (by id) to its new contents.
   #You may input a hash you have already built or void and begin 
   #building your data hash in this function.
   def load_data_with_partials(hash=nil)
      if(@partials != nil)     #if a partial has actually been submitted
         hash ||= {};          #if nil, make a hash. (return value)
         hash[:htmlElts] = {}; #hash for each elementID<=>newHTML pair
         
         @partials.each { |p| #for each partial submitted
            partial_id = find_partial_name(p[0].to_s);

            #build the html from embedded ruby files in views and relevant inputs
            hash[:htmlElts][partial_id] = ERB.new(render_to_string(render_function_hash(p))).result;
         }
      end
      return hash;
   end
     
   #use this to update (and add) the input to the partial
   def update_partial_input(partial_file, key=nil, value=nil)
      @partials ||= {};
      @partials[partial_file.to_sym] ||= {} #hash for inputs
      if(!key.nil?) #don't save input if there was none
         @partials[partial_file.to_sym][key.to_sym] = value;
      end
      return;
   end
  
   
   private
   
   #generates structure for input to render_to_string()
   def render_function_hash(input_pair_array)
      hash = {};
      hash[:partial] = input_pair_array[0].to_s;
      if(!input_pair_array.empty?) #if this partial has inputs
         hash[:locals]  = input_pair_array[1]; #put in hash
      end
      return hash;
   end
   
   #used to extract the id to the primary div of the partial
   #which should be the name of the partial wihtout any file path
   def find_partial_name(file_path)
      return name = file_path.split('/').last.to_sym;
   end
   
   
   def stock_ajax_handler_helper(stocks)
      if user_signed_in?
        @price_of_tot_stock = Stock.get_total_stock_price(current_user.id)
        @market_events_paginate = MarketEvent.page(1).per(10)
        @notifications_list = Notification.select("notification,updated_at").where('user_id' => current_user.id).last(10).reverse

        update_partial_input('dalal_dashboard/partials/panel_dashboard_partial', :@price_of_tot_stock ,  @price_of_tot_stock)
        update_partial_input('dalal_dashboard/partials/panel_dashboard_partial', :@stocks_list, stocks )
        update_partial_input('dalal_dashboard/partials/panel_dashboard_partial', :@market_events_paginate , @market_events_paginate)
        update_partial_input('dalal_dashboard/partials/stock_partial', :@stocks_list, stocks)
        update_partial_input('dalal_dashboard/partials/notification_partial', :@notifications_list , @notifications_list)

        data = {}
        data = load_data_with_partials(data)
        WebsocketRails[:show].trigger(:show_channel, "true")
        broadcast_message :stock_ajax_handler, data
      end
   end

   def buy_sell_stock_socket_helper
       if user_signed_in?
              Stock.connection.clear_query_cache
              # @notifications_list = Notification.select("notification,updated_at").where('user_id' => current_user.id).last(10).reverse
              @stocks_list = Stock.all
              @market_events_paginate = MarketEvent.page(1).per(10)

              @price_of_tot_stock = Stock.get_total_stock_price(current_user.id)
              update_partial_input('dalal_dashboard/partials/main_buy_sell_partial', :@stocks_list, @stocks_list)
              # update_partial_input('dalal_dashboard/partials/notification_partial', :@notifications_list , @notifications_list)
              update_partial_input('dalal_dashboard/partials/panel_dashboard_partial', :@price_of_tot_stock ,  @price_of_tot_stock)
              update_partial_input('dalal_dashboard/partials/panel_dashboard_partial', :@stocks_list, @stocks_list )
              update_partial_input('dalal_dashboard/partials/panel_dashboard_partial', :@market_events_paginate , @market_events_paginate)
  
              data = {}
              data = load_data_with_partials(data)
              send_message :buy_sell_stock_socket, data
       end
   end

end
