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
		@item.starting_bid = @item.next_bid
		if @bid.save && @item.save
			flash[:notice] = "Your bid has been placed successfully."
			redirect_to members_item_path(@item)
		else
			redirect_to members_item_path(@item)
		end
	end

end
