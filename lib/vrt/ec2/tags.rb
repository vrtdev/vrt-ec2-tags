# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'uri'
require 'vrt/ec2/tags/version'

module Vrt
  module Ec2
    # This module will fetch the EC2 tags for this instance via custom lambda.
    module Tags
      def self.tags
        yamlstring = read_tags
        puts yamlstring if yamlstring
      rescue StandardError => e
        warn "Something failed.... Abort! : #{e.class} - #{e.message}"
      end

      def self.meta_data_uri
        @meta_data_uri || @meta_data_uri = URI.parse('http://169.254.169.254')
      end

      def self.tag_uri
        @tag_uri || @tag_uri = URI.parse('https://puppetapi.core.a51.be/tags')
      end

      def self.read_tags
        response = request_tags
        case response
        when Net::HTTPSuccess
          response.body
        when Net::HTTPUnauthorized
          raise("#{response.message}: username and password set and correct?")
        when Net::HTTPServerError
          raise("#{response.message}: try again later?")
        else
          raise(response.message)
        end
      end

      def self.request_tags
        http = Net::HTTP.new(tag_uri.host, tag_uri.port)
        http.use_ssl = true
        http.open_timeout = 2
        http.read_timeout = 4
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        request = Net::HTTP::Post.new(tag_uri)
        request.add_field 'Content-Type', 'text/plain; charset=utf-8'
        request.body = instance_id
        http.request(request)
      end

      def self.instance_id
        id = read_instance_id
        raise('Something bad happened since there was no error but this is not a string.') unless id.is_a? String

        id
      rescue StandardError
        warn 'This is not an AWS EC2 instance or unable to contact the AWS instance-data web server.'
      end

      def self.read_instance_id
        http = Net::HTTP.new(meta_data_uri.host, meta_data_uri.port)
        http.open_timeout = 2
        http.read_timeout = 4
        request = Net::HTTP::Get.new('/latest/dynamic/instance-identity/rsa2048')
        http.request(request).body
      end
    end
  end
end

# vi:set fileencoding=utf8 fileformat=unix filetype=ruby tabstop=2 expandtab:
