class ProjectCli::Scraper
  def self.scrape_region
    doc = Nokogiri::HTML(open("https://www.mtbproject.com/directory/8007709/florida"))
    doc.search(".area a").map {|i| i.attribute("href").value}
  end
  
  
end
