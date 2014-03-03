class SearchesController < ApplicationController
    def index
      if params[:del]
        FileUtils.rm_rf(Dir.glob(Rails.root+'public/uploads/*'))
        redirect_to "/searches"
      end
      if params[:a] && params[:b]
          @me_image = 'uploads/' + params[:a]
          @you_image = 'uploads/' + params[:b]
          me_file_path = Rails.root+'public'+ @me_image
          you_file_path = Rails.root+'public'+ @you_image
          
          
          
          file_exists = File.exists?(me_file_path ) && File.exists?(you_file_path )

          unless file_exists
            flash.now[:error] = "Wrong file name:"
            return
          end
          
          `br -algorithm FaceRecognition -compare #{me_file_path} #{you_file_path} metadata.csv`
          score = File.open('metadata.csv').read().split(',').last
          flash.now[:notice] = "Matching score: #{score}"
          
      end
      @images = Dir.glob('public/uploads/*').collect{|f| f.split('/')[1..-1].join('/')}
    end   

    def upload_file
      puts "-------__!!!!!!!!!!!!-------------------"
      name = params[:upload].original_filename
      directory = "public/uploads"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:upload].read) }
      flash[:notice] = "#{name.upcase} uploaded"
      redirect_to "/searches"
    end
end