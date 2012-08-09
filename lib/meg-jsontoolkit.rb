require 'yaml'
require 'open-uri'
require 'base64'

require "meg-jsontoolkit/version"

module Meg
  module Jsontoolkit
    class << self
      def starts_with?(string, prefix)
        prefix = prefix.to_s
        string[0, prefix.length] == prefix
      end

      def base64_encode_file(path)
        return unless path.is_a? String

        if File.exists?(path) && !File.directory?(path)
          data = Base64.strict_encode64(open(path) { |io| io.read })
          mime = IO.popen(["file", "--brief", "--mime-type", path], in: :close, err: :close).read.chomp
          return "data:#{mime};base64,#{data}" unless data.empty?
        end
      end

      def url_with_asset_host(url, asset_host)
        if starts_with?(url, 'http')
          full_url = url
        else
          full_url = [asset_host, url].join('/') 
        end
        full_url
      end

      def color_with_pound(string)
        color = ''
        if string.is_a?(String) && !string.nil? && string != ''
          color = starts_with?(string, '#')? string : '#' + string
        end
        color
      end

      def relation_json(table, collection)
        table = table.to_s if table.is_a? Symbol
        error = false

        # check table param
        error = true if table.nil?
        error = true if table == ''

        # check collection param
        if collection.is_a?(Enumerable)
          error |= collection.empty?
          key = :uuids
        else
          error |= !collection.is_a?(String)
          key = :uuid
        end

        hash = Hash.new
        unless error
          hash[:table] = table
          hash[key] = collection
        end
        hash
      end 
    end
  end
end
