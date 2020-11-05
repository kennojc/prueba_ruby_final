require "net/http"
require 'json'

api_url= "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&"
api_key= "api_key=DEMO_KEY"

def request (url,key)
    url = URI("#{url}#{key}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    body = JSON.parse response.read_body
     
end


def build_web_page (hash)
    sources = []
    rover_photos = hash.fetch('photos')
    rover_photos.length.times do |i|
        sources << rover_photos[i]['img_src']
    end
    puts sources.class 
    print sources
        
    

end



hash_from_nasa = request(api_url,api_key)
build_web_page(hash_from_nasa)

