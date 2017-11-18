module Aliyun::Mns
  class Queue
    attr_reader :name

    delegate :to_s, to: :name

    class << self
      def [] name
        Queue.new(name)
      end

      def queues opts={}
        mns_options = {query: "x-mns-prefix", offset: "x-mns-marker", size: "x-mns-ret-number"}
        mns_headers = opts.slice(*mns_options.keys).reduce({}){|mns_headers, item| k, v = *item; mns_headers.merge!(mns_options[k]=>v)}
        response = Request.get("/", mns_headers: mns_headers)
        Hash.xml_array(response, "Queues", "Queue").collect{|item| Queue.new(URI(item["QueueURL"]).path.sub!(/^\//, ""))}
      end
    end

    def initialize name
      @name = name
    end

    def create opts={}
      response = Request.put(queue_path) do |request|
        msg_options = {
          :VisibilityTimeout => 30,
          :DelaySeconds => 0,
          :MaximumMessageSize => 65536,
          :MessageRetentionPeriod => 345600,
          :PollingWaitSeconds => 0}.merge(opts)
        request.content :Queue, msg_options
      end
    end

    def delete
      Request.delete(queue_path)
    end

    def send_message message, opts={}
      Request.post(messages_path) do |request|
        msg_options = {:DelaySeconds => 0, :Priority => 10}.merge(opts)
        request.content :Message, msg_options.merge(:MessageBody => message.to_s)
      end
    end

    def receive_message wait_seconds: nil
      request_opts = {}
      request_opts.merge!(params:{waitseconds: wait_seconds}) if wait_seconds
      result = Request.get(messages_path, request_opts)
      Message.new(self, result)
    end

    def peek_message
      result = Request.get(messages_path, params: {peekonly: true})
      Message.new(self, result)
    end

    def batch_peek_message number_of_messages=16
      result = Request.get(messages_path, params: {peekonly: true, numOfMessages: number_of_messages})
      messages = Hash.xml_array(result, "Messages")
      messages.map{|message|
        BatchMessages.new(self, message)
      }
    end

    def queue_path
      "/queues/#{name}"
    end

    def messages_path
      "/queues/#{name}/messages"
    end

  end
end
