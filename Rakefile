desc "Ejecucion del servidor con los parametros predefinidos"
task :default do
  sh "bundle exec rackup"
end


desc "Ejecutar las Pruebas Unitarias"
task :test do
  sh "ruby ./test/test_rps.rb"
end

desc "Ejecutar Rspec"
task :spec do
  sh "rspec spec/rsack/server_spec.rb"
end
