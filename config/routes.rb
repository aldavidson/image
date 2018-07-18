Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resourceful routes not being recognised in 5.2, only the activestorage engine
  # maybe a bug? no time to look into it right now
  # resources 'images', only: [:get, :post, :delete]
  post  '/images', to: 'image#create'
  get   '/images/:id', to: 'image#show'

end
