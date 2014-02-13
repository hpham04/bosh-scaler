require 'net/http'
require 'net/https'
require 'yajl'
require 'yaml'
require 'eventmachine'
require 'nats/client'
require 'logger'
require 'bosh/monitor'

require 'scaler/collector.rb'
require 'scaler/collectors/bosh_nats_collector.rb'
require 'scaler/collectors/bosh_rest_collector.rb'
require 'scaler/collectors/cf_varz_collector.rb'

require 'scaler/listeners/bosh_scaler.rb'
require 'scaler/listeners/bosh_scaler/heartbeat_processor.rb'
require 'scaler/listeners/bosh_scaler/cf_varz_processor.rb'
require 'scaler/listeners/bosh_scaler/conditions.rb'

require 'scaler/bosh_client.rb'
require 'scaler/task.rb'
require 'scaler/event_processor.rb'
require 'scaler/cf_varz_metrics.rb'

require 'scaler/deployment.rb'
require 'scaler/deployment/job.rb'
require 'scaler/deployment/resource_pool.rb'

require 'scaler/runner.rb'