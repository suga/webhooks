Dir[File.expand_path "src/*.rb"].each{|f| require_relative(f)}
require 'tempfile'

describe LogHelper do

  before(:each) do
    @file_temp_log = Tempfile.new(['webhook','.txt'])
    @file_temp_log.write('level=info response_body="" request_to="https://surrealostrich.com.br" response_headers=map[Server:[nginx] X-Request-Id:[1381e8cb388db085cdc3bac457dab9bf] Date:[Tue, 07 Jul 2015 18:29:52 GMT] Set-Cookie:[X-Mapping-fjhppofk=A67D55AC8119CAD031E35EC35B4BCFFD; path=/] Content-Type:[text/html; charset=utf-8] X-Powered-By:[Phusion Passenger (mod_rails/mod_rack) 3.0.17] X-Rack-Cache:[invalidate, pass] X-Runtime:[0.034645] Connection:[keep-alive] Keep-Alive:[timeout=20] Cache-Control:[max-age=0, private, must-revalidate] Status:[200] Etag:[7215ee9c7d9dc229d2921a40e899ec5f] Vary:[Accept-Encoding] X-Ua-Compatible:[IE=Edge,chrome=1]] response_status="200"')
    @file_temp_log.write('level=info response_body="" request_to="https://surrealostrich.com.br" response_headers=map[Server:[nginx] X-Request-Id:[1381e8cb388db085cdc3bac457dab9bf] Date:[Tue, 07 Jul 2015 18:29:52 GMT] Set-Cookie:[X-Mapping-fjhppofk=A67D55AC8119CAD031E35EC35B4BCFFD; path=/] Content-Type:[text/html; charset=utf-8] X-Powered-By:[Phusion Passenger (mod_rails/mod_rack) 3.0.17] X-Rack-Cache:[invalidate, pass] X-Runtime:[0.034645] Connection:[keep-alive] Keep-Alive:[timeout=20] Cache-Control:[max-age=0, private, must-revalidate] Status:[200] Etag:[7215ee9c7d9dc229d2921a40e899ec5f] Vary:[Accept-Encoding] X-Ua-Compatible:[IE=Edge,chrome=1]] response_status="200"')
    @file_temp_log.write('level=info response_body="" response_headers=map[Server:[nginx] X-Request-Id:[1381e8cb388db085cdc3bac457dab9bf] Date:[Tue, 07 Jul 2015 18:29:52 GMT] Set-Cookie:[X-Mapping-fjhppofk=A67D55AC8119CAD031E35EC35B4BCFFD; path=/] Content-Type:[text/html; charset=utf-8] X-Powered-By:[Phusion Passenger (mod_rails/mod_rack) 3.0.17] X-Rack-Cache:[invalidate, pass] X-Runtime:[0.034645] Connection:[keep-alive] Keep-Alive:[timeout=20] Cache-Control:[max-age=0, private, must-revalidate] Status:[200] Etag:[7215ee9c7d9dc229d2921a40e899ec5f] Vary:[Accept-Encoding] X-Ua-Compatible:[IE=Edge,chrome=1]] response_status="201"')
    @file_temp_log.write('level=info response_body="" request_to="https://severeleather.com" response_headers=map[Content-Type:[application/json; charset=utf-8] Connection:[keep-alive] Runscope-Message-Id:[fb814900-c6bc-4002-8007-e7e06b52abb0] Access-Control-Allow-Credentials:[true] Server:[Runscope-Gateway/1.0]] response_status="503"')
    @file_temp_log.write('level=info response_body="" request_to="https://severeleather.com" response_headers=map[Content-Type:[application/json; charset=utf-8] Connection:[keep-alive] Runscope-Message-Id:[fb814900-c6bc-4002-8007-e7e06b52abb0] Access-Control-Allow-Credentials:[true] Server:[Runscope-Gateway/1.0]] response_status="503"')
    @file_temp_log.write('level=info response_body="" request_to="https://easterncobra.com.br" response_headers=map[Content-Type:[application/json; charset=utf-8] Connection:[keep-alive] Runscope-Message-Id:[fb814900-c6bc-4002-8007-e7e06b52abb0] Access-Control-Allow-Credentials:[true] Server:[Runscope-Gateway/1.0]] response_status="400"')
    @file_temp_log.write('level=info response_body="" request_to="https://abandonedpluto.com" response_headers=map[Content-Type:[application/json; charset=utf-8] Connection:[keep-alive] Runscope-Message-Id:[fb814900-c6bc-4002-8007-e7e06b52abb0] Access-Control-Allow-Credentials:[true] Server:[Runscope-Gateway/1.0]] response_status="201"')
    @file_temp_log.rewind
  end

  after(:each) do
    @file_temp_log.close
    @file_temp_log.unlink
  end

  context 'top_requests_whit' do
    it 'When we have 4 requests and show all' do
      webhook = Webhook.new(log_file:@file_temp_log.read)
      log_helper = LogHelper.new(webhook:webhook)
      expect(log_helper.top_requests_whit(limit:4)).to eq({["https://severeleather.com"]=>2,
                                                           ["https://surrealostrich.com.br"]=>2,
                                                           ["https://abandonedpluto.com"]=>1,
                                                           ["https://easterncobra.com.br"]=>1})
    end
    it 'When we have 4 requests and show just 3' do
      webhook = Webhook.new(log_file:@file_temp_log.read)
      log_helper = LogHelper.new(webhook:webhook)
      expect(log_helper.top_requests_whit(limit:3)).to eq({["https://severeleather.com"]=>2,
                                                           ["https://surrealostrich.com.br"]=>2,
                                                           ["https://abandonedpluto.com"]=>1})
    end
    it 'When we have 4 requests and show just 1' do
      webhook = Webhook.new(log_file:@file_temp_log.read)
      log_helper = LogHelper.new(webhook:webhook)
      expect(log_helper.top_requests_whit(limit:1)).to eq({["https://severeleather.com"]=>2})
    end
    it 'When we have 4 requests and show 5' do
      webhook = Webhook.new(log_file:@file_temp_log.read)
      log_helper = LogHelper.new(webhook:webhook)
      expect(log_helper.top_requests_whit(limit:5)).to eq({["https://severeleather.com"]=>2,
                                                           ["https://surrealostrich.com.br"]=>2,
                                                           ["https://abandonedpluto.com"]=>1,
                                                           ["https://easterncobra.com.br"]=>1})
    end
  end

  context 'status_table' do
    it 'When we set up the status table' do
      webhook = Webhook.new(log_file:@file_temp_log.read)
      log_helper = LogHelper.new(webhook:webhook)
      expect(log_helper.status_table).to eq({["200"]=>2, ["201"]=>2, ["400"]=>1, ["503"]=>2})
    end
  end

end