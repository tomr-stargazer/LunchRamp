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

#returns an array of the closest "numRests" restaurants within "dist" meters sorted by distance - I think numRests maxes at 20 for some reason
def closestRests(numRests, dist, access_token)
  path = "/v2/search?term=restaurants&ll=37.786704,-122.401209&radius_filter=#{dist}&sort=1&limit=#{numRests}"
  closest_rests = []
  jsonHash = JSON.parse(access_token.get(path).body)
  businessArray=jsonHash['businesses']
  return businessArray
end


#returns similar array, now sorted by top rating
def topRests(numRests, dist, access_token)
  path = "/v2/search?term=restaurants&ll=37.786704,-122.401209&radius_filter=#{dist}&sort=0&limit=#{numRests}"
  toprated_rests = []
  jsonHash = JSON.parse(access_token.get(path).body)
  businessArray=jsonHash['businesses']
  return businessArray
end


def putsArrayNames(array)
  array.each do |x|
    puts "#{x['name']}"
  end
end

def printArrayNames(array)
  print "#{array[0]['name']}"
  array[1..array.size].each do |x|
    print ", #{x['name']}"
  end
end

def tellXRests(x, access_token)
  puts "The #{x} nearest restaurants to LiveRamp are:\n"
  putsArrayNames(closestRests(x, 500, access_token))

  puts "\n\nand the #{x} highest rated restaurants near LiveRamp are:\n"
  printArrayNames(topRests(x, 500, access_token))
end


def getRandRestClosest(x, access_token)
  return closestRests(x, 500, access_token)[rand(x)]['name']
end

10.times do
  puts "Your random restaurant is #{getRandRestClosest(10, access_token)}"
end

