task :fetch_tweets => :environment do
  UrlsController.tweetfetch
end