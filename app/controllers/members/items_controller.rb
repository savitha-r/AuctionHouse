class Members::ItemsController < Members::MembersController
	before_filter :check_expire, :only => [:bid]

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
		if @bid.save
			@item.place_bid
			@item.delay(run_at: @item.ending_time, :item_id => @item.id).item_expired
			flash[:notice] = "Your bid has been placed successfully."
		else
			flash[:notice] = "There was an error placing the bid please try again."
		end
		redirect_to members_item_path(@item)
	end

	private

	def check_expire
		@item = get_entity Item.find_by_id(params[:item_id])
		if @item.check_expire
			flash[:notice] = "The bidding time has expired for this item."
			redirect_to members_items_path
		end
	end

end
