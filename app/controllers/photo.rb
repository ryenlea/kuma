# encoding: UTF-8
Kuma::App.controllers :photos do
  
  get :index do
    @photos = Photo.all
    render json: @photos.collect {|p| p.to_jq_upload}.to_json 
  end

  post :upload , csrf_protection: false do
    content_type :js
    #binding.pry
    @photo = Photo.new(params[:photo])
    @photo.category = 1
    if @photo.save!
        "#{@photo.to_jq_upload.to_json}"
    else
        "{error:'failure'}"
    end
  end
end
