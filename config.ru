require_relative 'lib/middleware/simpler_logger'
require_relative 'config/environment'

use SimplerLogger
run Simpler.application
