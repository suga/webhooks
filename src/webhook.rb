class Webhook
  attr_reader :regex_request_to, :regex_response_status, :log_file

  def initialize(log_file:)
    @regex_request_to = /request_to="(http[s]?:\/\/[\w\d]+\.[\w\d]*+\.*[\w\d]*)"/
    @regex_response_status = /response_status="([\d]*)"/
    @log_file = log_file
  end

  def parser_request_to
    @log_file.scan(@regex_request_to)
  end

  def parser_response_status
    @log_file.scan(@regex_response_status)
  end

end