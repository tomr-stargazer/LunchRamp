require 'rubygems'
require 'oauth'
require 'json'

consumer_key = 'YiR3GbfH02O15qSJDwbOGw'
consumer_secret = 'uonkCO1e8gg9ZNKmTs2RY7xTQ_A'
token = '2fDh6TTELI8ZQ4N2QCcL4y899EIk2RUw'
token_secret = 'nfMaTuD1tggp1Qz5_HyIOX-qU7I'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)

numRests = 20

path = "/v2/search?term=restaurants&ll=37.786704,-122.401209&radius_filter=500&sort=1&limit=#{numRests}"

closest_rests = []

jsonHash = JSON.parse(access_token.get(path).body)
businessArray=jsonHash['businesses']
businessArray.each do |x|
  closest_rests += [x['name']]
end

path = "/v2/search?term=restaurants&ll=37.786704,-122.401209&radius_filter=500&sort=0&limit=#{numRests}"

toprated_rests = []

jsonHash = JSON.parse(access_token.get(path).body)
businessArray=jsonHash['businesses']
businessArray.each do |x|
  toprated_rests += [x['name']]
end

puts "The #{numRests} nearest restaurants to LiveRamp are:\n"
closest_rests.each do |x|
  puts "- #{x}"
end

puts "\n\nand the #{numRests} highest rated restaurants near LiveRamp are:\n"
toprated_rests.each do |x|
  puts "- #{x}"
end 
