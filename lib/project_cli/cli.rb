class ProjectCli::Cli
  def call
    puts "Looking for a trail?"

    list_trails


  end

  def list_trails
    quit_trigger = true
    while quit_trigger
      puts "Would you like to search by region, county, difficulty? Or would you like to see all the trails?                  [region/county/difficulty/all/quit]"
      input = gets.strip

      case input
      when "region"
        search_by_region
      when "county"
        search_by_county
      when "difficulty"
        search_by_difficulty
      when "all"
        list_all_trails
      when "quit"
        quit_trigger = false
      else
        puts "Please enter a valid input."
      end
    end
  end

  def search_by_county
    second_level = true
    puts "Please enter county: [options]"
    search_county = gets.strip.capitalize
    list = ProjectCli::Trail.search_by_county(search_county)
    while second_level
      puts "Trails in #{search_county} county:"
      list.each_with_index {|x, i| puts "#{i+1}. #{x.name}"}
      puts "Select a trail to see more information, or type back to return to main menu: [number/back]"
      input = gets.strip
      if input.capitalize == "Back"
        second_level = false
      elsif input.to_i.to_s == input
        int_input = input.to_i - 1
        if list[int_input] != nil
          trail = list[int_input]
          third_level = true
          puts trail.name
          puts "Region: #{trail.region}"
          puts "County: #{trail.county}"
          #puts "Difficulty: #{trail.difficulty}"
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
        #  else
          #  puts "Please enter a valid input."
          end
        end
      else
        puts "Please enter valid input."
      end
    end
  end

  def search_by_region
    second_level = true
    puts "Please enter region: "
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
          trail = list[int_input]
          third_level = true
          puts trail.name
          puts "Region: #{trail.region}"
          puts "County: #{trail.county}"
          #puts "Difficulty: #{trail.difficulty}"
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
        #  else
          #  puts "Please enter a valid input."
          end
        end
      else
        puts "Please enter valid input."
      end
    end
  end

  def search_by_difficulty(difficulty)
    difficulty
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
        puts list[int_input].name
        puts "County: #{list[int_input].county}"
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
