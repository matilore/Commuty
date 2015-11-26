Rails.application.routes.draw do
  devise_for :users	
    resources :users do
    	resources :posts
	end
	resources :requests do
		resources :revisions
	end

	get '/home' => "posts#home"
	get "/" => "sites#index"
end
