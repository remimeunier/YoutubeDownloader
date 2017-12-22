require 'http'
require 'json'
class MyFreeMp3

  def self.send_request(input)
    response = HTTP.headers(:authority => "my-free-mp3.net",
                            :origin    => "https://my-free-mp3.net",
                            :referer   => "https://my-free-mp3.net/"
                           )
                   .post("https://my-free-mp3.net/api/search.php?callback=jQuery213014355676196990985_1513875534320",
                         :form => {:q => input,
                                   :sort => '2',
                                   :count => '3000',
                                   :perform_only => '0'
                                  }
                       )
                   .body.to_s.match(/(?<=jQuery213014355676196990985_1513875534320\()(.*)(?=\);)/).captures.first
    JSON.parse(response)['response']
  end
end
