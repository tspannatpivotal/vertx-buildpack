require 'java_buildpack/component/versioned_dependency_component'
require 'java_buildpack/container'

module JavaBuildpack
  module Container
    class Vertx < JavaBuildpack::Component::VersionedDependencyComponent
     
      def initialize(context)
	  super(context)
      end	  

      def supports?
	 verticle?
      end
      
      def compile
	 download(@version,@uri) {|file| expand file}
	 FileUtils.mkdir_p apps
	 shell "zip -j #{zip_name} #{@droplet.root}/*"	
      end
      
      def release
	 [
	   @droplet.java_home.as_env_var,
	   @droplet.java_opts.as_env_var,
	   "$PWD/#{(@droplet.sandbox + 'bin/vertx').relative_path_from(@droplet.root)}",
           'runzip',
           "$PWD/#{(@droplet.sandbox+'apps').relative_path_from(@droplet.root)}/#{@application.details['application_name']}-1.0.0.zip"		   

        ].flatten.compact.join(' ')	      
      end	      
      
      def zip_name 
         "#{apps}/#{@application.details['application_name']}-1.0.0.zip"
      end	      

      def apps
          @droplet.sandbox + "apps"
      end	      

      def verticle?
	 (@application.root + 'mod.json').exist?     
      end	      
      
      def expand(file)
	with_timing "Expanding Vertx to #{@droplet.sandbox.relative_path_from(@droplet.root)}" do
        FileUtils.mkdir_p @droplet.sandbox
        shell "tar xzf #{file.path} -C #{@droplet.sandbox} --strip 1 2>&1"
	end
      end
    end	    
  end	  
end	
