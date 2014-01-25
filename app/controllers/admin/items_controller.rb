class Admin::ItemsController < Admin::AdminController
	before_filter :convert_dates, :only => [:create]

	def index
		@items = Item.all
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_parameters)
		if @item.save
			@item.delay(run_at: @item.ending_time, :item_id => @item.id).item_expired
			redirect_to admin_item_path(@item)
		else
			render "new"
		end
	end

	def edit
		@item = get_entity Item.find_by_id(params[:id])
	end

	def update
		@item = get_entity Item.find_by_id(params[:id])
		@item.assign_attributes(item_parameters)
		if @item.save
			redirect_to admin_item_path(@item)
		else
			render "edit"
		end

	end

	def show
		@item = get_entity Item.find_by_id(params[:id])
	end

	def destroy
		@item = get_entity Item.find_by_id(params[:id])
		@item.destroy!
		redirect_to admin_items_path
	end

	private

	def convert_dates
		params[:item][:starting_time] = params[:item][:starting_time].to_datetime
		params[:item][:ending_time] = params[:item][:ending_time].to_datetime
	end

	def item_parameters
		params.require(:item).permit(:name, :description, :starting_time, :ending_time, :bid_unit, :starting_bid)
	end

end
