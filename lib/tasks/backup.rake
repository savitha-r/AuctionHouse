namespace :backup do
	task :report => :environment do
	  @items = Item.order(:name)
	  path = Rails.root.to_s + '/tmp/report/report.csv'
	  File.open(path, 'w') {|f| f.write(Item.to_csv(@items)) }
	end
end
