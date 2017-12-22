require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative 'decoder'
require_relative 'item'
require_relative 'item_list'
require_relative 'my_free_mp3'
require_relative 'music_link'
require_relative 'downloader'

playlist_url = "https://www.youtube.com/playlist?list=PLs9B-3qyUAJWQKK3LoZHaL288WnQJWmQF"

doc = Nokogiri::HTML(open(playlist_url))
item_list = ItemList.new
doc.css("a.pl-video-title-link").each do |item|
  item_list.add(Item.new(title: item.text.gsub("\n",'')))
end
downloader = Downloader.new(items_list: item_list)
downloader.download
