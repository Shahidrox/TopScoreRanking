Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs/v1'
  mount Rswag::Api::Engine => '/api-docs/v1'

  namespace 'api' do
    namespace 'v1' do
      resources :scores, only: [:index, :create, :show, :destroy] do
        collection do
          get '/playerscorehistory/:player/:score' => 'scores#player_history', as: 'player_history'
        end
      end
    end
  end
end