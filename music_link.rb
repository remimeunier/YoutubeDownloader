require_relative 'decoder'
class MusicLink

  attr_reader :aid, :owner_id, :artist, :title, :duration, :download_link

  def initialize(args)
    json           = args.fetch(:json, '')
    @id            = parse_id(json)
    @owner_id      = parse_owner_id(json)
    @artist        = parse_artist(json)
    @title         = parse_title(json)
    @duration      = parse_duration(json)
    @download_link = "https://streams.my-free-mp3.net/" + Decoder.decode(@owner_id) + ":" + Decoder.decode(@id)
  end

  def to_s
    "#{@artist} - #{@title} : #{@download_link}"
  end

  private

  def parse_id(json)
    json['id']
  end
  def parse_owner_id(json)
    json['owner_id']
  end
  def parse_artist(json)
    json['artist']
  end
  def parse_title(json)
    json['title']
  end
  def parse_duration(json)
    json['duration']
  end
end
