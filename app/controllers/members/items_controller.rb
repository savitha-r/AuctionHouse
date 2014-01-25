class Members::ItemsController < Members::MembersController

	def index
		current_time = DateTime.now
		@items = Item.where("ending_time > ?", current_time)
	end

	def show
		@item = get_entity Item.find_by_id(params[:id])
	end

	def bid
		@item = get_entity Item.find_by_id(params[:item_id])
		@bid = Bid.initialize_with_defaults(@item,current_user,@item.next_bid)
		@item.price = @item.place_bid
		if @bid.save
			flash[:notice] = "Your bid has been placed successfully."
		else
			flash[:notice] = "There was an error placing the bid please try again."
		end
		redirect_to members_item_path(@item)
	end

end
