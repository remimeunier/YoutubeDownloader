class MusicLinkList

  attr_reader :music_links, :title

  def initialize(args)
    @title         = args.fetch(:title, '')
    @music_links   = build_music_links
  end

  def get_best_link
    {resource: @music_links.first.download_link, filename: @music_links.first.title + '.mp3'}
  end

  def have_link?
    !music_links.nil?
  end

  private

  def build_music_links
    json = MyFreeMp3.send_request(@title)
    result_number = json.length
    if result_number == 0
      list = nil
    else
      list = []
      (1..[10, result_number].min).each do |i|
        list << MusicLink.new(json: json[i])
      end
    end
    list
  end
end
