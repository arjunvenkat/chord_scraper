ChordScraper::Application.routes.draw do

  root :to => 'pages#search'

  get '/search' => 'pages#search'
  
  post '/results'=> 'pages#results'
end
