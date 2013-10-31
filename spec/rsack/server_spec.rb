require 'spec_helper'

describe Rsack::Server do
	def server
		Rack::MockRequest.new(Rsack::Server.new)
    end

    # Si estamos en modo index sin haber realizado ninguna jugada.
	context '/' do

		it "Debería devolver el codigo de status 200 si todo esta bien" do
	        response = server.get('/')
	        response.status.should == 200
		end

		it "No encuetra Hello World en el body" do
        	response = server.get('/')
        	expect(response.body).not_to eq('Hello World')
        end
	end

	# Si jugamos con tijeras.
	context "/?jugada='Tijeras'" do

		it "Debería devolver el código 200" do
	        response = server.get("/?jugada='Tijeras'")
	        response.status.should == 200
		end

		it "Debería si la eleccion del jugador ha sido Tijeras deberia aparecer la imagen de Tijeras" do
		    response = server.get("/?jugada='Tijeras'")
		    response.body.include?("http://i1296.photobucket.com/albums/ag1/adrihg89/tijeras_zps543ca9ac.jpg")
		end

		it "Si el jugador tira Tijeras y la maquina Papel deberia GANAR" do
			computer_throw = 'Papel'
			response = server.get("/?jugada='Tijeras'")
			response.body.include?("Muy bien, Tijeras gana a Papel. ¿Te atreves a seguir jugando?")
		end

		it "Si el jugador tira Tijeras y la maquina Piedra deberia PERDER" do
			computer_throw = 'Piedra'
			response = server.get("/?jugada='Tijeras'")
			response.body.include?("Oh has perdido, Piedra gana a Tijeras. Sigue intentandolo, ¡Suerte!")
		end

		it "Si el jugador tira Tijeras y la maquina Tijeras deberia EMPATAR" do
			computer_throw = 'Tijeras'
			response = server.get("/?jugada='Tijeras'")
			response.body.include?("Estas salvado, Tijeras contra Tijeras es un empate.")
		end

		
	end

	# Si jugamos con papel.
	context "/?jugada='Papel'" do

		it "Debería devolver el código 200" do
	        response = server.get("/?jugada='Papel'")
	        response.status.should == 200
		end

		it "Debería si la eleccion del jugador ha sido Papel deberia aparecer la imagen de Papel" do
		    response = server.get("/?jugada='Papel'")
		    response.body.include?("http://i1296.photobucket.com/albums/ag1/adrihg89/paper_zpse0ed0ca5.jpg")
		end

		it "Si el jugador tira Papel y la maquina Piedra deberia GANAR" do
			computer_throw = 'Piedra'
			response = server.get("/?jugada='Papel'")
			response.body.include?("Muy bien, Papel gana a Piedra. ¿Te atreves a seguir jugando?")
		end

		it "Si el jugador tira Papel y la maquina Tijeras deberia PERDER" do
			computer_throw = 'Tijeras'
			response = server.get("/?jugada='Papel'")
			response.body.include?("Oh has perdido, Tijeras gana a Papel. Sigue intentandolo, ¡Suerte!")
		end

		it "Si el jugador tira Papel y la maquina Papel deberia EMPATAR" do
			computer_throw = 'Papel'
			response = server.get("/?jugada='Papel'")
			response.body.include?("Estas salvado, Papel contra Papel es un empate.")
		end

		
	end

	# Si jugamos con piedra.
	context "/?jugada='Piedra'" do

		it "Debería devolver el código 200" do
	        response = server.get("/?jugada='Piedra'")
	        response.status.should == 200
		end

		it "Debería si la eleccion del jugador ha sido Piedra deberia aparecer la imagen de Piedra" do
		    response = server.get("/?jugada='Piedra'")
		    response.body.include?("http://i1296.photobucket.com/albums/ag1/adrihg89/rock_zps0ebe7421.jpg")
		end

		it "Si el jugador tira Piedra y la maquina Tijeras deberia GANAR" do
			computer_throw = 'Tijeras'
			response = server.get("/?jugada='Piedra'")
			response.body.include?("Muy bien, Piedra gana a Tijeras. ¿Te atreves a seguir jugando?")
		end

		it "Si el jugador tira Piedra y la maquina Papel deberia PERDER" do
			computer_throw = 'Papel'
			response = server.get("/?jugada='Piedra'")
			response.body.include?("Oh has perdido, Papel gana a Piedra. Sigue intentandolo, ¡Suerte!")
		end

		it "Si el jugador tira Piedra y la maquina Piedra deberia EMPATAR" do
			computer_throw = 'Piedra'
			response = server.get("/?jugada='Piedra'")
			response.body.include?("Estas salvado, Piedra contra Piedra es un empate.")
		end

		
	end

end