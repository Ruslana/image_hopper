require "open-uri"
require "net/http"

require "image_hopper/version"
require "image_hopper/image"

module ImageHopper
  class Cutter
    
    attr_accessor :site_url, :dir_path, :images
    
    USER_AGENT = "Google Chrome 26.0.1410.43"
    MIN_SIZE = 4000
    
    def initialize(site_url, dir_path)
      @site_url = site_url
      @dir_path = dir_path
      @images = []
    end
    
    def download
      page_host = URI.parse(site_url).host
      parse = URI.parse(site_url)
      content = open(parse).read
      
      content.scan(/['"]+([^'"]+\.(?:#{Image::IMAGE_EXTENSIONS.join('|')}))[^'"]*['"]+/i) {|result| 
        line = result[0];
        line.gsub!(/^.*?url\(/,''); 
        line.gsub!(/\)/,''); 
        images.push Image.new(page_host, URI.escape(line))
      }

      images.each {|image|
        url = URI.parse(URI.encode(image.full_src.strip))
        request = Net::HTTP::Get.new(url.path)

        Net::HTTP.start(url.host) {|http|
          file = open("#{dir_path+image.file_name}", "wb")
          begin
            http.request_get(request.path, "User-Agent"=> USER_AGENT) do |response|
              file_size = response['content-length']
              if file_size.to_i > MIN_SIZE
                response.read_body do |segment|
                  file.write(segment)
                end
              else
                File.delete(file)
              end
            end
          ensure
            file.close()
          end
        }
      }
    end
  end
end
