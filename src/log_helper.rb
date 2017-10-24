class LogHelper
  attr_reader :webhook

  def initialize(webhook:)
    @webhook = webhook
  end

  def top_requests_whit(limit:)
    requests = @webhook.parser_request_to
    group_requests = group_by(items:requests).sort_by { |_key, value| value }.reverse
    Hash[group_requests.slice!(0,limit)]
  end

  def status_table
    status = @webhook.parser_response_status
    Hash[group_by(items:status).sort_by { |key, _value| key }]
  end

  def group_by(items:)
    Hash[items.group_by(&:itself).map { |item, block| [item, block.size] }]
  end

  private :group_by
end