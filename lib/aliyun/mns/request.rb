require 'base64'
module Aliyun::Mns

  class RequestException < Exception
    attr_reader :content
    delegate :[], to: :content

    def initialize ex
      @content = Hash.xml_object(ex.to_s, "Error")
    rescue
      @content = {"Message" => ex.message}
    end
  end

  class Request
    attr_reader :uri, :method, :date, :body, :content_md5, :content_type, :content_length, :mns_headers
    delegate :access_id, :key, :host, to: :configuration

    class << self
      [:get, :delete, :put, :post].each do |m|
        define_method m do |*args, &block|
          options = {method: m, path: args[0], mns_headers: {}, params: {}}
          options.merge!(args[1]) if args[1].is_a?(Hash)
          request = Aliyun::Mns::Request.new(options)
          block.call(request) if block
          request.execute
        end
      end
    end

    def initialize method: "get", path: "/", mns_headers: {}, params: {}
      conf = {
        host: host,
        path: path
      }
      conf.merge!(query: params.to_query) unless params.empty?
      @uri = URI::HTTP.build(conf)
      p @uri
      @method = method
      @mns_headers = mns_headers.merge("x-mns-version" => "2015-06-06")
    end

    def content type, values={}
      ns = "http://mns.aliyuncs.com/doc/v1/"
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.send(type.to_sym, xmlns: ns) do |b|
          values.each{|k,v| b.send k.to_sym, v}
        end
      end
      @body = builder.to_xml
      @content_md5 = Base64::encode64(Digest::MD5.hexdigest(body)).chop
      @content_length = body.size
      @content_type = "text/xml;charset=utf-8"
    end

    def execute
      date = DateTime.now.httpdate
      headers =  {
        "Authorization" => authorization(date),
        "Content-Length" => content_length || 0,
        "Content-Type" => content_type,
        "Content-MD5" => content_md5,
        "Date" => date,
        "Host" => uri.host
      }.merge(mns_headers).reject{|k,v| v.nil?}
      begin
        RestClient.send *[method, uri.to_s, body, headers].compact
      rescue RestClient::Exception => ex
        raise RequestException.new(ex)
      end
    end

    private
    def configuration
      Aliyun::Mns.configuration
    end

    def authorization date
      canonical_resource = [uri.path, uri.query].compact.join("?")
      canonical_mq_headers = mns_headers.sort.collect{|k,v| "#{k.downcase}:#{v}"}.join("\n")
      method = self.method.to_s.upcase
      signature = [method, content_md5 || "" , content_type || "" , date, canonical_mq_headers, canonical_resource].join("\n")
       sha1_digest = OpenSSL::Digest.new('sha1')
       digest = OpenSSL::HMAC.digest(sha1_digest, key, signature)
      "MNS #{access_id}:#{Base64.encode64(digest).chop}"
    end

  end
end
