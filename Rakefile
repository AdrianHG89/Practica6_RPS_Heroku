desc "Ejecutar servidor para lanzar la aplicacion"
task :default do
  sh "rackup"
end


desc "Ejecutar las Pruebas Unitarias"
task :test do
  sh "ruby ./test/test_rps.rb"
end

desc "Ejecutar Rspec"
task :spec do
  sh "rspec spec/rsack/server_spec.rb"
end
