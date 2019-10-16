class ProjectCli::Scraper
  def self.scrape_region
    doc = Nokogiri::HTML(open("https://www.mtbproject.com/directory/8007709/florida"))
    doc.search(".area a").map {|i| i.attribute("href").value}
  end
  
  def self.area_urls
    #return array of hashes with area name and trail_urls
    #doc = Nokogiri::HTML(open("https://www.mtbproject.com/directory/8007797/central-florida#sub-areas"))
    #binding.pry
    area_hashes = self.scrape_region.map do |region|
      doc = Nokogiri::HTML(open(region))
      doc.search("div.col-sm-6 div.area a").map do |i|
        output = {}
        output[:region] = i.search("h1").text
        output[:area] = i.search("div.link").text
        output[:url] = i.attribute("href").value
        output
      end
    end
    area_hashes.flatten
  end
  
  
  def self.trail_urls
    output = self.scrape_region.map do |region|
      doc = Nokogiri::HTML(open(region))
      doc.search(".trail-table .trail-row a").map {|i| i.attribute("href").value}
    end
    output.flatten
  end
  
  def self.trails
    self.trail_urls.map do |trail|
      doc = Nokogiri::HTML(open(trail))
      output = {}
      output[:name] = doc.search("#trail-title").text.strip
      output[:county] = doc.search("ol.breadcrumb li.breadcrumb-item a span.hidden-sm-down")[1].text
      output[:difficulty] = doc.search("div.trail-subheader div.difficulty-banner span.difficulty-text").text
      output
    end
    #doc = Nokogiri::HTML(open("https://www.mtbproject.com/trail/7008967/gatorback"))
    #binding.pry
  end
end
