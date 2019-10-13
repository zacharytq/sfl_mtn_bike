class ProjectCli::Scraper
  def self.scrape_region
    doc = Nokogiri::HTML(open("https://www.mtbproject.com/directory/8007709/florida"))
    doc.search(".area a").map {|i| i.attribute("href").value}
  end
  
  def self.trail_urls
    doc = Nokogiri::HTML(open("https://www.mtbproject.com/directory/8007797/central-florida"))
    doc.search(".trail-table .trail-row a").map {|i| i.attribute("href").value}
  end
  
  def self.trails
    self.trail_urls
  end
end
