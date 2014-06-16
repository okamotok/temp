require 'debugger'              # optional, may be helpful
require 'open-uri'              # allows open('http://...') to return body
require 'cgi'                   # for escaping URIs
require 'nokogiri'              # XML parser
require 'active_model'          # for validations

class OracleOfBacon

  class InvalidError < RuntimeError ; end
  class NetworkError < RuntimeError ; end
  class InvalidKeyError < RuntimeError ; end

  attr_accessor :from, :to
  attr_reader :api_key, :response, :uri

  include ActiveModel::Validations
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :api_key
  validate :from_does_not_equal_to

  def from_does_not_equal_to
    errors.add(:to, "Same actor") if @from == @to
  end

  def initialize(api_key='38b99ce9ec87')
    @api_key = api_key
    @to = 'Kevin Bacon'
    @from = 'Kevin Bacon'
  end

  def find_connections
    make_uri_from_arguments
    begin
      xml = URI.parse(uri).read
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
      Net::ProtocolError => e
      # convert all of these into a generic OracleOfBacon::NetworkError,
      #  but keep the original error message
      # your code here
    end
    # your code here: create the OracleOfBacon::Response object
  end

  def make_uri_from_arguments
    base = 'http://oracleofbacon.org/cgi-bin/xml'
    key = '?p=' + CGI::escape(@api_key)
    from = '?a=' + CGI::escape(@from)
    to = '?b=' + CGI::escape(@to)
    @uri = base + key + from + to
  end

  class Response
    attr_reader :type, :data
    # create a Response object from a string of XML markup.
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
      parse_response
    end

    private

    def parse_response
      if ! @doc.xpath('/error').empty?
        parse_error_response
      elsif !@doc.xpath('/spellcheck').empty?
        parse_spellcheck
      elsif !@doc.xpath('/link').empty?
        parse_link
      else
        @type = :unknown
        @data = 'unknown response type'
      end
    end

    def parse_link
      @type = :graph
      @data = @doc.xpath('/link/actor | /link/movie').map { |node| node.text }

    end

    def parse_spellcheck
      @type = :spellcheck
      nodeset = @doc.xpath('//match')
      @data = nodeset.map { |node| node.text }
    end

    def parse_error_response
      @type = :error
      @data = 'Unauthorized access'
    end
  end
end

