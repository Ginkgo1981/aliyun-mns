module Aliyun::Mns
  class BatchMessage


    def initialize queue, hash_message
      h = hash_message
      @queue = queue
      @id = h["MessageId"]
      @body_md5 = h["MessageBodyMD5"]
      @body = h["MessageBody"]
      @enqueue_at = Time.at(h["EnqueueTime"].to_i/1000.0)
      @first_enqueue_at = Time.at(h["FirstDequeueTime"].to_i/1000.0)
      @next_visible_at = Time.at(h["NextVisibleTime"].to_i/1000.0) if h["NextVisibleTime"]
      @dequeue_count = h["DequeueCount"].to_i
      @priority = h["Priority"].to_i
      @receipt_handle = h["ReceiptHandle"]
    end

  end
end
