desc "Demo for database connection"
task :demo => :environment do  # Rake does not load the rails environment by default. We need to do that explicitly in order to give it access to our models and classes
  @p = Player.new
  @p.player_name = "Pappu"
  if @p.save
    puts "Saved Successfully"
  else
    puts "some error"
    puts @p.errors
  end
end
