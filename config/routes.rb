Rails.application.routes.draw do
  devise_for :users	
    resources :users do
    	resources :posts
	end
	
	resources :requests
	resources :revisions
	resources :comments, except: [:new, :edit, :show]

	get '/home' => "posts#home"
	get "/comments/:post_id" => "comments#show_per_post"
	get "/" => "sites#index"
end
