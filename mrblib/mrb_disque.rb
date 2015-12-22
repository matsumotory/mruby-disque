class Disque
  def initialize host="127.0.0.1", port=7711
    @obj = Redis.new host, port
    self
  end

  # ADDJOB queue_name job <ms-timeout> [REPLICATE <count>] [DELAY <sec>] [RETRY <sec>] [TTL <sec>] [MAXLEN <count>] [ASYNC]
  # is the following
  # addjob "queue_name", "job", "5", "REPLICATE", "3", "DELAY", "2", "RETRY", "5", "TTL", "10", "MAXLEN", "4", "ASYNC"
  def addjob *args
    @obj.queue :addjob, *args
    @obj.reply.to_s
  end
  def getjob *queue_names
    @obj.queue :getjob, "from", *queue_names
    GetJobReply.new @obj.reply
  end

  # GETJOB [NOHANG] [TIMEOUT <ms-timeout>] [COUNT <count>] [WITHCOUNTERS] FROM queue1 queue2 ... queueN
  # is the following
  # getjob_with_opts "NOHANG", "TIMEOUT", "10", "COUNT", "5", "WITHCOUNTERS", "FROM", "queue1", "queue2", "queueN"
  def getjob_with_opts *args
    @obj.queue :getjob, *args
    GetJobReply.new @obj.reply
  end

  # DELJOB <job-id> ... <job-id>
  def deljob *job_ids
    @obj.queue :deljob, *job_ids
    @obj.reply
  end

  # custom disque API
  # ref: https://github.com/antirez/disque#main-api
  def run_command api_name, *args
    @obj.queue api_name.to_sym, *args
    @obj.reply
  end

  class GetJobReply
    attr_reader :queue_name, :job_id, :job_name
    def initialize reply
      @queue_name = reply[0][0]
      @job_id = reply[0][1]
      @job_name = reply[0][2]
    end
  end
end
