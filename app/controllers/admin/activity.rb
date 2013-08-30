Kuma::App.controllers :activities, :map => 'admin/activities' do
    get :index do
      "admin index"
    end

    get :show, :with => :activity_id, :map => '' do

    end
end
