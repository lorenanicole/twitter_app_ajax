require 'pry'

get '/' do

  $client

  # $client.update("I'm tweeting with @gem from Johore, Malayasia!!", :lat => 1.3000, :long => 103.8000, :display_coordinates => true)
  erb :index
end

post '/temp' do
  puts params
  @user = TwitterUser.find_by_username(params[:username])
  if @user == nil
    @user = TwitterUser.create(username: params[:username])
    @user.fetch_tweets!
    # redirect "/#{params[:username]}"
  else
    @user.tweets_stale?
  end
  @tweets = @user.tweets.all
  # redirect "/#{params[:username]}"
  string = "<ul>"
  @tweets.each do |tweet|
    string += "<li>#{tweet.body}</li>"
  end
  string += "</ul>"
  puts string
  string
end

# get '/:username' do
#   @user = TwitterUser.find_by_username(params[:username])
#   @tweets = @user.tweets.limit(10).all
#   puts "#{@tweets}"
#   erb :user_page
# end
