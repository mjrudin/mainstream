class UrlsController < ApplicationController
  
  def index
    @array = []
    TweetStream::Client.new.sample(language: 'en') do |status, client|
      link = status.text.match(/http:\/\/t\.co\/[a-zA-Z0-9]+/)
     if link
       @array.push(link[0])
 
        # status.text.scan(/#\w+/).each do |h|
 #          Hashtag.create(tag: h.sub!("#", ""), url_id: Url.last.id)
 #        end
      end
      client.stop if @array.length >= 15
   end

    @array.each do |link|
      until link.nil?
        final_link = link
        isSSL = link.match(/https:\/\//)
        if isSSL
          uri = URI.parse(link)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl =true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)
          link = response['location']
        else
          link = Net::HTTP.get_response(URI.parse(link))['location']
        end
      end
      
      l = Url.find_or_create_by_link(final_link) do |c|
            c.frequency += 1
          end
          l.frequency += 1
    end

    
    Url.all.each do |u|
      url = 'https://readability.com/api/content/v1/parser?url=' + "#{u.link}" + '&token=b9a8aa67a490c643bd12efd3d861c05a2a665927'
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl =true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      
      response = JSON.parse(response.body)
      u.update_attributes(article: response['content'], 
                          author: response['author'],
                          title: response['title'],
                          word_count: response['word_count'],
                          date_published: response['date_published'])
      @articles = Url.all 
    end
 
  end
  
  def show
    @selected_article = Url.find_by_id(params[:id])
    render :show
  end
  
end

