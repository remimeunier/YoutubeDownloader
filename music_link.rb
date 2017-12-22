require_relative 'decoder'
class MusicLink

  attr_reader :aid, :owner_id, :artist, :title, :duration, :download_link

  def initialize(args)
    @aid           = parse_aid(args.fetch(:json, ''))
    @owner_id      = parse_owner_id(args.fetch(:json, ''))
    @artist        = parse_artist(args.fetch(:json, ''))
    @title         = parse_title(args.fetch(:json, ''))
    @duration      = parse_duration(args.fetch(:json, ''))
    @download_link = "https://streams.my-free-mp3.net/" + Decoder.decode(@owner_id) + ":" + Decoder.decode(@aid)
  end

  def to_s
    "#{@artist} - #{@title} : #{@download_link}"
  end


  private

  def parse_aid(json)
    json['aid']
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
