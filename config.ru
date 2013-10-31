require './lib/rps.rb'


	use Rack::Static, :urls => ['/public']
	use Rack::ShowExceptions
	use Rack::Lint
	run RockPaperScissors::RPS.new

	use Rack::Session::Cookie,
		:key => 'rack.session',
		:secret => 'some_secret'