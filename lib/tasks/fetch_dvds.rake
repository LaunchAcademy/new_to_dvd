require 'net/http'
require 'open-uri'

namespace :fetch_dvds do

  task :test => :environment do
    movies = []
    root = 'http://www.rottentomatoes.com'
    url_text = Net::HTTP.get(URI.parse "#{root}/dvd/new-releases/")
    doc = Nokogiri::HTML(url_text)
    doc.css('.movie_item .media_block_content').each do |movie|
      binding.pry
      movies << {
        title:    movie.css('.heading h2 a').text,
        link:     root + movie.css('.heading h2 a')[0]['href'],
        rating:   movie.css('.heading .tMeterScore').text,
        staring:  movie.css('div:not(.subtle) a').map{|a| a.text}.slice(1..-1),
        synopsis: movie.css('> p').text,
        info:     movie.css('.subtle').text.split('-').first
      }
    end
  end
end
