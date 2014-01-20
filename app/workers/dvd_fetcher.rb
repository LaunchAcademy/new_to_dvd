require 'net/http'
require 'open-uri'

class DVDFetcher
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    # fetch and send dvd email every tuesday
    weekly.day(:tuesday)

    # every 15 seconds for testing
    # minutely.second_of_minute(0,15,30,45)
  end

  def perform
    movies = {}
    root = 'http://www.rottentomatoes.com'
    url_text = Net::HTTP.get(URI.parse "#{root}/dvd/new-releases/")
    doc = Nokogiri::HTML(url_text)
    doc.css('.movie_item .media_block_content').each_with_index do |movie, i|
      movies[i] = {
        title:    movie.css('.heading h2 a').text,
        link:     root + movie.css('.heading h2 a')[0]['href'],
        rating:   movie.css('.heading .tMeterScore').text,
        staring:  movie.css('div:not(.subtle) a').map{|a| a.text}.slice(1..-1),
        synopsis: movie.css('> p').text,
        info:     movie.css('.subtle').text.split('-').first.gsub("—", '')
      }
    end
    info = ReleaseInfo.create(data: movies)

    User.wanting_email.each do |user|
      DVDMailer.delay.new_releases(info.id, user.id)
    end
  end
end
