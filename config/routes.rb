Rails.application.routes.draw do
  devise_for :users	
    resources :users do
    	resources :posts
	end
	
	resources :requests
	resources :revisions

	get '/home' => "posts#home"
	get "/" => "sites#index"
end
