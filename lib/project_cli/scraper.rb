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
        output[:region] = doc.search("h1")
        output[:area] = i.search("div.link").text
        output[:url] = i.attribute("href").value
        output
      end
    end
    area_hashes.flatten
  end
  
  
  def self.trails
    output = self.area_urls.map do |area|
      doc = Nokogiri::HTML(open(area[:url]))
      doc.search(".trail-table .trail-row").map do |i|
        output_hash = area.clone
        output_hash[:name] = i.search("a.text-black strong").text
        output_hash[:difficulty] = i.search("span.difficulty-text").text
        output_hash
      end
    end
    output.flatten
  end
  
  
end
