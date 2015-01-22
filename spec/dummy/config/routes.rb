Rails.application.routes.draw do
  post 'camp_minder_handler', to: 'dummy_camp_minder_handler#create'
end
