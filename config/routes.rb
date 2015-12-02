Rails.application.routes.draw do
  devise_for :users	
    resources :users do
    	resources :posts
	end
	
	resources :requests
	resources :revisions
	resources :comments, except: [:new, :edit, :show]

	get "/" => "sites#index"
	get "/comments/:post_id" => "comments#show_per_post"
	post "/categories/" => "posts#categories"
end
