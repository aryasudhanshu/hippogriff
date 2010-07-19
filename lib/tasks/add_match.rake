require 'open-uri'
require 'hpricot'


namespace :scrape do
    
  desc "Picks out match ids from fixture pages soccernet and saves it to file tmp/urls.txt - 4 weeks at a time"
  task :build_list, :url do |t, args|
    file = File.open("tmp/urls.txt",'w+')
    url = "http://soccernet.espn.go.com/fixtures?league=eng.1&date=20090813&cc=4716"
    doc = Hpricot(open(url))
    doc.search(".tablehead tr:not('.stathead'):not('.colhead')").each do |row|
      begin
        id = row.search('td a')[1].to_s.match(/(id=)\d+/)[0].gsub("id=","")
      rescue
      end
      file.puts id unless id.nil?
    end
    puts "________________________________________________________________________________________________________________________________________"
    puts "List of match ids is now available in the file tmp/urls.txt. Use \'rake scrape:add_matches_from_list' to begin parsing and adding data."
    puts "________________________________________________________________________________________________________________________________________"
  end

  desc "Adds a match to the database given its soccernet link"
  task :add_matches_from_list => :environment do 
    file = File.open('tmp/urls.txt')
    file.each do |id|
      id=id.to_i
      next if id == 0
      @t = Time.now
      url = "http://soccernet.espn.go.com/match?id=#{id}&page=stats&cc=4716"
      doc = Hpricot(open(url))

      # Teams and other data
      @home_team_name    = doc.search('.boxscore-left .gamehead td')[2].innerHTML.gsub("\t","").gsub("\n","")
      @away_team_name    = doc.search('.boxscore-right .gamehead td')[1].innerHTML.gsub("\t","").gsub("\n","")
      @home_team_stadium = doc.search('.boxscore-left')[0].search('.oddrow td')[1].innerHTML.gsub("\t","").gsub("\n","").split(',')[0].strip
      @match_date        = doc.search('.oots h5').innerHTML.gsub("\n","").gsub("\t","")

      puts "----- Parsing data for #{@home_team_name} vs #{@away_team_name} played on #{@match_date} at #{@home_team_stadium} -----"

      url = "http://soccernet.espn.go.com/gamecast?id=#{id}&page=stats&cc=4716"
      doc = Hpricot(open(url))

      #Goals
      @goals = doc.search('.game-titleMain span').innerHTML.split('&nbsp;-&nbsp;')

      # Home Team - v[11] tells if player was in the starting lineup or not
      @home_team = {}
      count = 1
      doc.search("#homeTeamPlayerStats tr:not('.colhead')").each do |row|
        player_stats_array = []
        @player_name = row.search('td a').innerHTML
        row.search('.middle').each do |stat|
          player_stats_array << stat.innerHTML.to_i
        end
        if count > 11
          player_stats_array << false
        else
          player_stats_array << true
        end
        @home_team["#{@player_name}"] = player_stats_array
        count = count + 1
      end

      # Away Team - v[11] tells if player was in the starting lineup or not
      @away_team = {}
      doc.search("#awayTeamPlayerStats tr:not('.colhead')").each do |row|
        player_stats_array = []
        @player_name = row.search('td a').innerHTML
        row.search('.middle').each do |stat|
          player_stats_array << stat.innerHTML.to_i
        end
        if count > 11
          player_stats_array << false
        else
          player_stats_array << true
        end
        @away_team["#{@player_name}"] = player_stats_array
        count = count + 1
      end

      @home_team_match_stats = []
      @away_team_match_stats = []
      count = 1
      doc.search(".matchstats-wrapper tr:not('.colhead')").each do |row|
        row.search('td[@align=right]').each do |stat|
          if count%2 == 1
            @home_team_match_stats << stat.innerHTML
          else
            @away_team_match_stats << stat.innerHTML
          end
          count = count + 1
        end
      end

      puts "Completed in #{Time.now - @t} seconds, now adding data to the tables"
      @t = Time.now

      debugger

      # All the data is parsed and now to fill the databases!
      # # Adding teams, checking for duplication and pulling out team ids. This only adds team names and home stadiums. 
      @t1 = Team.find_or_create_by_team_name(@home_team_name)
      @t1.team_home_stadium = @home_team_stadium
      if not @t1.save
        puts "Was not able to save home team info to the database"
        puts @t1.errors
      end
      
      @t2 = Team.find_or_create_by_team_name(@away_team_name)
      if not @t2.save
        puts "Was not able to save away team info to the database"
        puts @t2.errors
      end
      
      # Adding match TODO - add gameweek information
      @m                    = Match.new
      @m.match_home_team_id = @t1.id
      @m.match_away_team_id = @t2.id
      @m.match_date         = @match_date
      @m.match_is_played    = true
      @m.match_year         = @match_date.split(',')[2]
      @m.match_home_team_type = "Team"
      @m.match_away_team_type = "Team"
      if not @m.save
        puts "Was not able to save match to database"
        puts @m.errors
      end
      
      #Add match stats - Home Team
      @mr                                        = MatchResult.new
      @mr.match_id                               = @m.id
      @mr.home_team_goals                        = @goals[0].to_i
      @mr.home_team_total_shots                  = @home_team_match_stats[0].gsub("\(",", ").gsub("\)","").split(', ')[0].to_i
      @mr.home_team_shots_on_target              = @home_team_match_stats[0].gsub("\(",", ").gsub("\)","").split(', ')[1].to_i
      @mr.home_team_yellow_cards                 = @home_team_match_stats[5].to_i
      @mr.home_team_red_cards                    = @home_team_match_stats[6].to_i
      @mr.home_team_possession                   = @home_team_match_stats[4].to_i      
      @mr.home_team_fouls                        = @home_team_match_stats[1].to_i      
      #Add match stats - Away Team
      @mr.away_team_goals                        = @goals[1].to_i
      @mr.away_team_total_shots                  = @away_team_match_stats[0].gsub("\(",", ").gsub("\)","").split(', ')[0].to_i
      @mr.away_team_shots_on_target              = @away_team_match_stats[0].gsub("\(",", ").gsub("\)","").split(', ')[1].to_i
      @mr.away_team_yellow_cards                 = @away_team_match_stats[5].to_i
      @mr.away_team_red_cards                    = @away_team_match_stats[6].to_i
      @mr.away_team_possession                   = @away_team_match_stats[4].to_i      
      @mr.away_team_fouls                        = @away_team_match_stats[1].to_i      
      #Add match result
      @goals[0]=@goals[0].to_i
      @goals[1]=@goals[1].to_i
      if @goals[0] > @goals[1]     
        @mr.home_team_result                    = "w"
        @mr.away_team_result                    = "l"
      elsif @goals[0] = @goals[1]
        @mr.home_team_result                    = "d"
        @mr.away_team_result                    = "d"
      else
        @mr.home_team_result                    = "l"
        @mr.away_team_result                    = "w"
      end
      if not @mr.save
        puts "Was not able to save match results to database"
        puts @mr.errors
      end
      
      # Add player match performance
      [@home_team, @away_team].each do |hash|
        hash.each do |name, stats|
          @p = Player.find_or_create_by_player_name(name)          
          @p.team = Team.find_or_create_by_team_name(@home_team_name)
          @pmp = PlayerMatchPerformance.new
          @pmp.player = @p
          @pmp.match  = @m
          @pmp.player_played       = true
          @pmp.player_started      = stats[10]
          @pmp.player_shots        = stats[0]
          @pmp.player_goals        = stats[1]
          @pmp.player_assists      = stats[2]
          @pmp.player_yellow_card  = stats[8]
          @pmp.player_red_card     = stats[9]
          @p.save
          @pmp.save
        end
      end


      puts "Data added in #{Time.now - @t} seconds. Moving on to the next match in the list."
      puts "---------------------------------------------------------------------------------------------"
      puts
    end
  end
end
