require 'test/unit'
require 'rack/test'
require './lib/rps.rb'

class Test_RPS < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Rack::Builder.new do
			run RockPaperScissors::RPS.new
		end.to_app
	end

	def test_index
		get "/"
		assert last_response.ok?
	end

	def test_title
		get "/"
		assert last_response.body.include?("<title>Practica - Piedra, Papel o Tijera</title>"), "El titulo debe ser 'Practica - Piedra, Papel o Tijera'"
    end

    def test_navbar
    	get "/"
    	assert_match "<a class='brand' href='https://github.com/AdrianHG89/Practica4_RPS_Haml-CSS'>Practica 3 - Juego Piedra, Papel o Tijera - STW-ETSII</a>", last_response.body
    end

	def test_hero_unit
		get "/"
		assert last_response.body.include?("<h1>Juega a Piedra, Papel o Tijera</h1>"), "La zona destacada debe tener este mensaje: Juega a Piedra, Papel o Tijera'."
		assert last_response.body.include?("<a class='btn btn-large btn-primary active' href='?jugada=Piedra'>Piedra</a>"), "La zona destacada debe tener enlace/boton Piedra."
		assert last_response.body.include?("<a class='btn btn-large btn-primary active' href='?jugada=Papel'>Papel</a>"), "La zona destacada debe tener enlace/boton Papel."
		assert last_response.body.include?("<a class='btn btn-large btn-primary active' href='?jugada=Tijeras'>Tijeras</a>"), "La zona destacada debe tener enlace/boton Tijera."
	end

	def test_row
		get "/"
		assert last_response.body.include?("<h2>Maquina</h2>"), "El body debe contener Maquina."
		assert last_response.body.include?("<h2>Vs.</h2>"), "El body debe contener Vs."
		assert last_response.body.include?("<h2>Jugador</h2>"), "El body debe contener Jugador."
	end

	def test_footer
        get"/"
        assert_match "<p>© 2013 Sistemas y Tecnologias Web - ETSII</p>", last_response.body
    end
end