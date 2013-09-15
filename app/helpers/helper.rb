Kuma::App.helpers do
	def date_formatter date
    date ||= Time.now
    date.strftime("%Y-%m-%d")
  end
  	
end
