require 'open-uri'
require 'hpricot'

namespace :scrape do


  desc "Builds a list of URLs on soccernet and saves it to file tmp/urls.txt - 4 weeks at a time"
  task :build_list, :url do |t, args|
    file = File.open('tmp/urls.txt','a+')
    url = "http://soccernet.espn.go.com/fixtures?league=eng.1&date=20090813&cc=4716"
    doc = Hpricot(open(url))
    ids = []
    doc.search(".tablehead tr:not('.stathead'):not('.colhead')").each do |row|
      begin
        id = row.search('td a')[1].to_s.match(/(id=)\d+/)[0].gsub("id=","")
      rescue
      end
      file.puts id unless id.nil?
    end
    puts "list on match ids is available in the file tmp/urls.txt"
  end


  desc "Adds a match to the database given its soccernet link"
  task :add_matches_from_list => :environment do 
    file = File.open('tmp/urls.txt')
    id = file.each do |id|
      @t = Time.now
      url = "http://soccernet.espn.go.com/match?id=#{id}&page=stats&cc=4716"
      doc = Hpricot(open(url))

      # Teams and other data
      @home_team_name    = doc.search('.boxscore-left .gamehead td')[2].innerHTML.gsub("\t","").gsub("\n","")
      @away_team_name    = doc.search('.boxscore-right .gamehead td')[1].innerHTML.gsub("\t","").gsub("\n","")
      @home_team_stadium = doc.search('.boxscore-left')[0].search('.oddrow td')[1].innerHTML.gsub("\t","").gsub("\n","")
      @match_date        = doc.search('.oots h5').innerHTML.gsub("\n","").gsub("\t","")

      puts "~~~~Parsing data for #{@home_team_name} vs #{@away_team_name} played on #{@match_date}~~~~"

      url = "http://soccernet.espn.go.com/gamecast?id=#{id}&page=stats&cc=4716"
      doc = Hpricot(open(url))

      # # Home Team - v[11] tells if player was in the starting lineup or not
      # @home_team = {}
      # count = 1
      # doc.search("#homeTeamPlayerStats tr:not('.colhead')").each do |row|
      #   player_stats_array = []
      #   @player_name = row.search('td a').innerHTML
      #   row.search('.middle').each do |stat|
      #     player_stats_array << stat.innerHTML
      #     if count > 11
      #       player_stats_array << false
      #     else
      #       player_stats_array << true
      #     end
      #   end
      #   @home_team["#{@player_name}"] = player_stats_array
      #   count = count + 1
      # end

      # # Away Team - v[11] tells if player was in the starting lineup or not
      # @away_team = {}
      # doc.search("#awayTeamPlayerStats tr:not('.colhead')").each do |row|
      #   player_stats_array = []
      #   @player_name = row.search('td a').innerHTML
      #   row.search('.middle').each do |stat|
      #     player_stats_array << stat.innerHTML
      #     if count > 11
      #       player_stats_array << false
      #     else
      #       player_stats_array << true
      #     end
      #   end
      #   @away_team["#{@player_name}"] = player_stats_array
      #   count = count + 1
      # end

      # @home_team_match_stats = []
      # @away_team_match_stats = []
      # count = 1
      # doc.search(".matchstats-wrapper tr:not('.colhead')").each do |row|
      #   row.search('td[@align=right]').each do |stat|
      #     if count%2 == 1
      #       @home_team_match_stats << stat.innerHTML
      #     else
      #       @away_team_match_stats << stat.innerHTML
      #     end
      #     count = count + 1
      #   end
      # end

      # All the data is parsed and now to fill the databases!

      puts "----Completed in #{Time.now - @t} seconds, now adding data to the tables----"
      puts

    end

  end
end
