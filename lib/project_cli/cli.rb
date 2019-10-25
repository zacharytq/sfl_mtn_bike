class ProjectCli::Cli
  def call
    ProjectCli::Trail.scrape_trails
    puts "Looking for a trail?"
    quit_trigger = true
    while quit_trigger
      puts "Would you like to search by region, county, difficulty? Or would you like to see all the trails?                  [region/difficulty/area/all/quit]"
      input = gets.strip.downcase

      case input
      when "region"
        search_by_region
      when "difficulty"
        search_by_difficulty
      when "area"
        search_by_city
      when "all"
        list_all_trails
      when "quit"
        quit_trigger = false
      else
        puts "Please enter a valid input."
      end
    end
  end
  
  def search_by_city
    second_level = true
    areas = ProjectCli::Trail.all.map{|a| a.area}.uniq
    puts "In what area would you like to search?"
    areas.each{|b| puts b}
    search_area = gets.strip.capitalize
    list = ProjectCli::Trail.find_trails_by_area(search_area)
    while second_level
      puts "Trails in #{list.first.area}:"
      list.each_with_index {|x, i| puts "#{i+1}. #{x.name}"}
      puts "Select a trail to see more information, or type back to return to main menu: [number/back]"
      input = gets.strip
      if input.capitalize == "Back"
        second_level = false
      elsif input.to_i.to_s == input
        int_input = input.to_i - 1
        if list[int_input] != nil
          print_trail(list, input)
          third_level = true
          while third_level
            puts "Would you like to go back to your results, or return to the main menu? [back/main]"
            response = gets.strip
            case response.capitalize
            when "Back"
              third_level = false
            when "Main"
              second_level = false
              third_level = false
            else
              puts "Please enter a valid input."
            end
          end
        end
      else
        puts "Please enter valid input."
      end
    end
  end

  def search_by_region
    second_level = true
    puts "Please enter region: [Central Florida/Southern Florida/Northern Florida/Florida Panhandle/Miami Metro]"
    search_region = gets.strip.capitalize
    list = ProjectCli::Trail.search_by_region(search_region)
    while second_level
      puts "Trails in #{search_region} region:"
      list.each_with_index {|x, i| puts "#{i+1}. #{x.name}"}
      puts "Select a trail to see more information, or type back to return to main menu: [number/back]"
      input = gets.strip
      if input.capitalize == "Back"
        second_level = false
      elsif input.to_i.to_s == input
        int_input = input.to_i - 1
        if list[int_input] != nil
          print_trail(list, input)
          third_level = true
          while third_level
            puts "Would you like to go back to your results, or return to the main menu? [back/main]"
            response = gets.strip
            case response.capitalize
            when "Back"
              third_level = false
            when "Main"
              second_level = false
              third_level = false
            else
              puts "Please enter a valid input."
            end
          end
        end
      else
        puts "Please enter valid input."
      end
    end
  end
  
  def print_trail(trails, input)
    if input.to_i.to_s == input && input.to_i <= trails.length
      trail = trails[input.to_i - 1]
      puts trail.name
      puts "Region: #{trail.region}"
      puts "Area: #{trail.area}"
      puts "Difficulty: #{trail.difficulty}"
    else
      puts "Please enter valid input."
    end
  end

  def search_by_difficulty
    second_level = true
    puts "Please enter difficulty: [Easy/Intermediate/Difficult/Extremely Difficult]"
    search_difficulty = gets.strip.downcase
    list = ProjectCli::Trail.find_trails_by_difficulty(search_difficulty)
    while second_level
      puts "#{list.first.difficulty} trails:"
      list.each_with_index {|x, i| puts "#{i+1}. #{x.name}"}
      puts "Select a trail to see more information, or type back to return to main menu: [number/back]"
      input = gets.strip
      if input.capitalize == "Back"
        second_level = false
      elsif input.to_i.to_s == input
        int_input = input.to_i - 1
        if list[int_input] != nil
          print_trail(list, input)
          third_level = true
          while third_level
            puts "Would you like to go back to your results, or return to the main menu? [back/main]"
            response = gets.strip
            case response.capitalize
            when "Back"
              third_level = false
            when "Main"
              second_level = false
              third_level = false
            else
              puts "Please enter a valid input."
            end
          end
        end
      else
        puts "Please enter valid input."
      end
    end
  end

  def list_all_trails
    second_level = true
    list = ProjectCli::Trail.all
    while second_level
      puts "All trails in Florida: "
      list.each_with_index {|i, index| puts "#{index + 1}. #{i.name}"}
      puts "Choose a trail to get more information, or go back to main menu. [number/back]"
      input = gets.strip
      int_input = input.to_i - 1
      if input == "back"
        second_level = false
      elsif input.to_i.to_s == input && list[int_input] != nil
        third_level = true
        print_trail(list, input)
        while third_level
          puts "Would you like to go back all trails, or return to main menu? [back, main]"
          response = gets.strip
          case response.capitalize
          when "Back"
            third_level = false
          when "Main"
            second_level = false
            third_level = false
          else
            puts "Please enter a valid input."
          end
        end
      else
        puts "Please enter a valid"
      end
    end


  end

end
