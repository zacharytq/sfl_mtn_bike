
class ProjectCli::Trail
  attr_accessor :name, :area, :region
  attr_reader :difficulty
  
  @@all = []
  def initialize
    @@all << self
  end

  def self.all
    @@all
  end
  
  def difficulty=(difficulty)
    case difficulty
    when "EasyEasy"
      @difficulty = "Easy"
    when "Easy/IntermediateEasy/Intermediate"
      @difficulty = "Easy/Intermediate"
    when "IntermediateIntermediate"
      @difficulty = "Intermediate"
    when "DifficultDifficult"
      @difficulty = "Difficult"
    when "Intermediate/DifficultIntermediate/Difficult"
      @difficulty = "Intermediate/Difficult"
    when "Extremely DifficultExtremely Difficult"
      @difficulty = "Extremely Difficult"
    else
      @difficulty = "Unknown"
    end
  end

  def self.list_all_trails
    self.all.each do |trail|
      puts trail.name
    end
  end

  def self.search_by_county(input)
    self.all.select {|i| i.county.capitalize == input.capitalize}
  end

  def self.search_by_region(input)
    self.all.select {|i| i.region.downcase == input.downcase}
  end
  
  def self.create_from_object(object)
    new_trail = ProjectCli::Trail.new
    new_trail.name = object[:name]
    new_trail.area = object[:area]
    new_trail.difficulty = object[:difficulty]
    new_trail.region = object[:region]
    
  end
  
  def self.scrape_trails
    ProjectCli::Scraper.trails.each do |trail|
      self.create_from_object(trail)
    end
  end
  
  def self.find_trails_by_area(input, list = self.all)
    list.select {|i| i.area.downcase == input.downcase}
  end
  
  def self.find_trails_by_region(input, list = self.all)
    list.select {|i| i.region == input}
  end
  
  def self.find_trails_by_difficulty(input, list = self.all)
    list.select do |i|
      if i.difficulty.split("/").any?{|j| j.downcase == input.downcase}
        i
      end
    end
  end
  
  def self.find_trail_by_name(input, list = self.all)
    list.select {|i| i.name.downcase == input.downcase}
  end
  
  
end
