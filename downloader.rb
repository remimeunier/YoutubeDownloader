# Modificate from :
# Author: Tobias Preuss
# Revision: 2013-04-18 16:26 +0100 UTC
# License: Creative Commons Attribution-ShareAlike 3.0 Unported

require 'net/http'
require 'uri'
require 'date'
require 'time'
require_relative 'item_list'

class Downloader

  attr_reader :items_list, :strategie

  def initialize(args)
    @items_list = args.fetch(:items_list, '')
  end

  def download
    target_dir_name = Time.now.getutc.to_s
    create_directory(target_dir_name)
    Dir.chdir(target_dir_name)
    puts "_______ Start Downloading _______"
    puts "_______"
    puts "Create directory: " + Dir.pwd
    puts "_______"
    uris = read_uris_list(@items_list)
    download_resources(uris)
  end

  private

  def create_directory(dirname)
    unless Dir.exists?(dirname)
      Dir.mkdir(dirname)
    else
      puts "Skipping creating directory " + dirname + ". It already exists."
    end
  end

  def read_uris_list(list)
    uris = Array.new
    list.items.each do |item|
      if item.music_link_list.have_link?
        pair = item.music_link_list.get_best_link
        uris.push(pair)
      else
        puts "Skipping download for " + item.title + ". No file found"
      end
    end
    uris
  end

  def download_resource(resource, filename)
    uri = URI.parse(resource)
    case uri.scheme.downcase
    when /http|https/
      http_download_uri(uri, filename)
    else
      puts "Unsupported URI scheme for resource " + resource + "."
    end
  end

  def http_download_uri(uri, filename)
    puts "Starting HTTP download for: " + filename + ' at '+uri.to_s
    http_object = Net::HTTP.new(uri.host, uri.port)
    http_object.use_ssl = true if uri.scheme == 'https'
    begin
      http_object.start do |http|
        request = Net::HTTP::Get.new uri.request_uri
        http.read_timeout = 500
        http.request request do |response|
          open filename, 'w' do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end
    rescue Exception => e
      puts "=> Exception: '#{e}'. Skipping download."
      return
    end
    puts "Stored download as " + filename + "."
    puts '_______'
  end

  def download_resources(pairs)
    pairs.each do |pair|
      filename = pair[:filename].to_s
      resource = pair[:resource].to_s
      unless File.exists?(filename)
        download_resource(resource, filename)
      else
        puts "Skipping download for " + filename + ". It already exists."
      end
    end
  end
end
