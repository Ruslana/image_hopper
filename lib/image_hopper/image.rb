module ImageHopper
  class Image
    attr_accessor :src, :file_name, :page_host, :full_src
  
    MIN_SIZE = 100
    IMAGE_EXTENSIONS = ["jpg","jpeg","png","gif","ico","svg","bmp"]
  
    def initialize(page_host, src)
      @page_host = page_host
      @src = src
      @file_name = @src.sub(/.*\//, '')
      @full_src = ((@src =~ /http/) ? @src : ('http://' + @page_host + '/' +  @src.sub(/^\/+/,'')))
    end
  end
end