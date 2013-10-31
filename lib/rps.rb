require 'rack/request'
require 'rack/response'
require 'haml'
require 'thin'
require 'rack'
  
module RockPaperScissors
	class RPS 
 		def initialize(app = nil)
			@app = app
			@content_type = :html
			@defeat = {'Piedra' => 'Tijeras', 'Papel' => 'Piedra', 'Tijeras' => 'Papel'}
			@throws = @defeat.keys
			#@ganadas=0
			#@perdidas=0
			#@empatadas=0
		end #Ende del def initialize

		def haml(template, resultado)
			template_file = File.open(template, 'r')
			Haml::Engine.new(File.read(template_file)).render({},resultado)
		end
		##################################################################

		####### Creamos la variable de las sesion #####
		def set_env(env)
			env = env
			@session = env['rack.session'] 
		end
		###################################################################

		####### Definimos el metodo que contara las partidas jugadas ######
		def jugadas
			return @session['jugadas'].to_i if @session['jugadas']
			@session['jugadas'] = 0
		end

		def jugadas=(value)
			@session['jugadas'] = value
		end
		###################################################################

		##### Definimos el contador encargado de las partidas ganadas #####
		def ganadas
			return @session['ganadas'].to_i if @session['ganadas']
			@session['ganadas'] = 0
		end

		def ganadas=(value)
			@session['ganadas'] = value
		end
		####################################################################

		##### Definimos el contador encargado de las partidas perdidas #####
		def perdidas
			return @session['perdidas'].to_i if @session['perdidas']
			@session['perdidas'] = 0
		end

		def perdidas=(value)
			@session['perdidas'] = value
		end
		#####################################################################

		##### Definimos el contador encargado de las partidas empatadas #####
		def empatadas
			return @session['empatadas'].to_i if @session['empatadas']
			@session['empatadas'] = 0
		end

		def empatadas=(value)
			@session['empatadas'] = value
		end
  
		def call(env)
			set_env(env)
			req = Rack::Request.new(env)

			computer_throw = @throws.sample
			player_throw = req.GET["jugada"]
			#ganadas=0
			#perdidas=0
			#empatadas=0
			resultados = ['Ganadas','Empatadas','Perdidas']
			
			if !@throws.include?(player_throw)
				anwser = "Realiza tu jugada."
			elsif player_throw == computer_throw
				#@empatadas = @empatadas + 1
				anwser = "Estas salvado, #{player_throw} contra #{computer_throw} es un empate."
				self.jugadas = self.jugadas + 1
       			self.empatadas = self.empatadas + 1					
			elsif computer_throw == @defeat[player_throw]
				#@ganadas = @ganadas + 1
				anwser = "Muy bien, #{player_throw} gana a #{computer_throw}. ¿Te atreves a seguir jugando?"
				self.jugadas = self.jugadas + 1
       			self.ganadas = self.ganadas + 1					
			else
				#@perdidas = @perdidas + 1
				anwser = "Oh has perdido, #{computer_throw} gana a #{player_throw}. Sigue intentandolo, ¡Suerte!"
				self.jugadas = self.jugadas + 1
				self.perdidas = self.perdidas + 1					
			end
			engine = Haml::Engine.new File.open("views/rps.html.haml").read
			variables ={
				:anwser => anwser,
				:resultados => resultados,
				:throws => @throws,				
				:computer_throw => computer_throw,
				#:ganadas => @ganadas,
				#:perdidas => @perdidas,
				#:empatadas => @empatadas,
				:jugadas => self.jugadas,
				:ganadas => self.ganadas,
				:perdidas => self.perdidas,
				:empatadas => self.empatadas,
				:player_throw => player_throw
			}
			res = Rack::Response.new(haml("views/rps.html.haml", variables))
		end # End del def call
	end #End de class
end #End del module
