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
    
    head = '
    <html>
    <head> 
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="utf-8">
        <title>| Fotos Rovers de la NASA |</title>
    </head>'

    header = '
    <body class="bg-dark" style="font-family: Impact, Haettenschweiler, sans-serif;">
    <header class="text-white bg-dark mb-5">
        <h1 class="text-center mt-3">De Ruby a la NASA</h1>      
    </header>'

    section='
    <section class="photos container-fluid text-center bg-secondary text-white">
    <h3 class="my-4 display-6">( Aquí Las Mejores 25 Fotos de Los Rovers )</h2>
    <hr class="my-3 p-2">'  

    body = '    <ul class="list-group">'
    css='class="list-group-item"'
    css2='class="w-50 h-auto"'
    sources.each do |e|
        body += "\n\t\t<li #{css}><img src=\"#{e}\" #{css2}></li>\n"
    end
    
    footer = '
    <footer class="mt-5 container-fluid text-white bg-info">
        <br>
        <div class="container mt-2 py-2">
        <div class="flex-container m-3 p-3 justify-content-center socialmedia">
        <h2 class="my-4 display-5 text-white font-weight-bold mr-5 text-center footerLogo"> By KennoJC</h2>
            <div><a href="https://github.com/kennojc" target="_blank"><i class="fab fa-github fa-5x mx-5 text-white"></i></a></div>
        </div>
        </div>
    </footer>
    </body>
    </html>'
    
    
    nasa_ruby = head+header+section+body+footer
    File.write('index.html', nasa_ruby)


end

hash_from_nasa = request(api_url,api_key)
build_web_page(hash_from_nasa)

