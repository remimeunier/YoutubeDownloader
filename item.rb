require_relative 'my_free_mp3'
require_relative 'music_link_list'
class Item

  attr_reader :title, :music_link_list

  def initialize(args)
    @title           = args.fetch(:title, '')
    @music_link_list = MusicLinkList.new(title: @title)
  end

  def get_download_url

  end

  def to_s
    "#{@title} "
  end
end
