class Disque
  def initialize host="127.0.0.1", port=7711
    @obj = Redis.new host, port
    self
  end

  # ADDJOB queue_name job <ms-timeout> [REPLICATE <count>] [DELAY <sec>] [RETRY <sec>] [TTL <sec>] [MAXLEN <count>] [ASYNC]
  def addjob *args
    @obj.queue :addjob, *args
    @obj.reply
  end
  def getjob *queue_names
    @obj.queue :getjob, "from", *queue_names
    @obj.reply
  end

  # GETJOB [NOHANG] [TIMEOUT <ms-timeout>] [COUNT <count>] [WITHCOUNTERS] FROM queue1 queue2 ... queueN
  def getjob_with_opts *args
    @obj.queue :getjob, *args
    @obj.reply
  end

  # DELJOB <job-id> ... <job-id>
  def deljob *args
    @obj.queue :deljob, *args
    @obj.reply
  end

  # custom disque API
  # ref: https://github.com/antirez/disque#main-api
  def run_command api_name, *args
    @obj.queue api_name.to_sym, *args
    @obj.reply
  end
end
