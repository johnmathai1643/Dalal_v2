module DalalDashboardHelper

  def gapper
    if @gap == 3
       @link = @link+"..."
       @gap = 1
    else
       @gap = @gap + 1
    end
  end
  
  def mojo_paginator(count,type=nil,active = 0)
  	@link = nil
    @gap = 1
    active = active.to_i
      
      @link = @link.to_s+"<a href='#paginator' onclick=update_modal_partials('#{active-1}','#{type}');> << </a>"
        count.to_i.times do |i|
          if active == i || active+1 == i || active+2 == i
           @link = @link.to_s+"<a href='#paginator' class='active' onclick=update_modal_partials('#{i}','#{type}');> #{i} </a>"
           gapper   
          elsif (count+active)/2 == i || (count+active)/2-1 == i || (count+active)/2+1 == i 
           @link = @link.to_s+"<a href='#paginator' onclick=update_modal_partials('#{i}','#{type}');> #{i} </a>"
           gapper
          elsif count == i || count-1 == i || count-2 == i
           @link = @link.to_s+"<a href='#paginator' onclick=update_modal_partials('#{i}','#{type}');> #{i} </a>"
           gapper
          else
           @link = @link
          end
        end  
      @link = @link.to_s+"<a href='#paginator' onclick=update_modal_partials('#{active+1}','#{type}');> >> </a>"
      
        return @link.html_safe
  end

#          <% @market_events_count.to_i.times do |i| %>
#          <a href="#paginator" <%= "onclick=update_modal_partials('#{i}','market');" %> ><%="#{i}"%></a>
#          <% end %>

end
