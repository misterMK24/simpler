Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:some_param', 'tests#show'
  post '/tests', 'tests#create'
end
