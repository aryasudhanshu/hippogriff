require 'open-uri'
require 'hpricot'

desc "Adds a match to the database given its soccernet link"
task :add_match => :environment do |t, args|
  url = "http://soccernet.espn.go.com/match?id=270001&page=stats&cc=4716"
  doc = Hpricot(open(url))

  # Teams
  @home_team_name    = doc.search('.boxscore-left .gamehead td')[2].innerHTML.gsub("\t","").gsub("\n","")
  @away_team_name    = doc.search('.boxscore-right .gamehead td')[1].innerHTML.gsub("\t","").gsub("\n","")
  @home_team_stadium = doc.search('.boxscore-left')[0].search('.oddrow td')[1].innerHTML.gsub("\t","").gsub("\n","")
  puts @home_team_name
  puts @away_team_name
  puts @home_team_stadium

  url = "http://soccernet.espn.go.com/gamecast?id=270001&page=stats&cc=4716"
  doc = Hpricot(open(url))

  # Home Team
  @home_team = []
  doc.search('.tablehead')[0].search('tr').each { |row|
    row.search('td') { |col| 
      
      name = col.search('a').innerHTML 
      @home_team << name
    }
  }

  # # Home Team Starting Line Up
  # @home_team_starting_line_up = []
  # doc.search('.boxscore-left')[1].search('tr td').each { |row|
  #   name     = row.search('a').innerHTML
  #   position = row.search('abbr').innerHTML
  #   @home_team_starting_line_up << name
  # }
  
  # # Away Team Starting Line Up
  # @home_team_starting_line_up = []
  # doc.search('.boxscore-left')[1].search('tr td').each { |row|
  #   name     = row.search('a').innerHTML
  #   position = row.search('abbr').innerHTML
  #   @home_team_starting_line_up << name
  # }

  

end
