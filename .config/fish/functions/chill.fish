function chill
  if count $argv > /dev/null
    set artist $argv
  else
    set artist (random choice Emancipator Bonobo Frameworks)
  end

  say Alexa, connect to the bluetooth speaker
  sleep 10
  say Alexa, play $artist on Spotify
end
