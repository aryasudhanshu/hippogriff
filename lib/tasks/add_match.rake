require 'open-uri'
require 'hpricot'

desc "Adds a match to the database given its soccernet link"
task :add_match => :environment do |t, args|
  @t = Time.now
  url = "http://soccernet.espn.go.com/match?id=270001&page=stats&cc=4716"
  doc = Hpricot(open(url))

  # Teams
  @home_team_name    = doc.search('.boxscore-left .gamehead td')[2].innerHTML.gsub("\t","").gsub("\n","")
  @away_team_name    = doc.search('.boxscore-right .gamehead td')[1].innerHTML.gsub("\t","").gsub("\n","")
  @home_team_stadium = doc.search('.boxscore-left')[0].search('.oddrow td')[1].innerHTML.gsub("\t","").gsub("\n","")

  url = "http://soccernet.espn.go.com/gamecast?id=270001&page=stats&cc=4716"
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


  # All the data is parsed and now to fill the databases!

  puts "took #{Time.now - @t} seconds to parse"

end

