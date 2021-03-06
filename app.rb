require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'nokogiri'

URL = 'http://dv.njtransit.com/mobile/tid-mobile.aspx?SID=NY&SORT=A'

get '/' do
	erb :'index.html'
end

get %r{/(.+)$} do |train|
	@train = train
	@status = train_status(train)

	if @status.include?(:error)
		erb :'error.html'
	else
		erb :'status.html'
	end
end

def train_status(train_number)
	doc = Nokogiri::HTML(open(URL, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0"))
	rows = doc.xpath('//tr').drop(2)

	rows.each do |row|
		data = row.children.map(&:content).map(&:strip)
		data.shift
		if data[8] == train_number
			return {
				time: data[0],
				destination: data[2],
				track: data[4],
				line: data[6],
				train: data[8],
				status: data[10],
				style: row.attributes['style']
			}
		end
	end

	{ error: 'Unavailable' }
end
