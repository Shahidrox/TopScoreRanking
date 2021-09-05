require 'rails_helper'

RSpec.describe Api::V1::ScoresController do

  describe "Create Score" do

    it " status = 400, invalid parameters" do
      post '/api/v1/scores', params: {player: Faker::Name.name, score: '', "time": Faker::Date.forward(days: 0)}
      expect(response.status).to eq(400)
    end

    it "Score can't be blank" do
      post '/api/v1/scores', params: {player: Faker::Name.name, score: '', "time": Faker::Date.forward(days: 0)}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(resp["message"][0]).to eq("Score can't be blank")
    end

    it "Set score String" do
      post '/api/v1/scores', params: {player: Faker::Name.name, score: Faker::Name.name, "time": Faker::Date.forward(days: 0)}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(resp["message"][0]).to eq("Score must be a number greater then zero")
    end

    it "Set score zero" do
      post '/api/v1/scores', params: {player: Faker::Name.name, score: 0, "time": Faker::Date.forward(days: 0)}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(resp["message"][0]).to eq("Score must be a number greater then zero")
    end

    it "Player can't be blank" do
      post '/api/v1/scores', params: {player: '', score: Faker::Number.number(digits: 2), "time": Faker::Date.forward(days: 0)}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(resp["message"][0]).to eq("Player can't be blank")
    end

    it "Time can't be blank" do
      post '/api/v1/scores', params: {player: Faker::Name.name, score: Faker::Number.number(digits: 2), "time": ''}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(resp["message"][0]).to eq("Time can't be blank")
    end

    it "status = 200, create by valid object" do
      post '/api/v1/scores', params: {player: Faker::Name.name, score: Faker::Number.number(digits: 2), "time": Faker::Date.forward(days: 0)}
      expect(response.status).to eq(200)
    end

  end

  describe "Get Score" do
    before do
      post '/api/v1/scores', params: {player: 'playerY', score: Faker::Number.number(digits: 2), "time": Faker::Date.forward(days: 0)}
      @resp = JSON.parse(response.body)
    end

    it "retrieve score by playerY - status = 404" do
      get '/api/v1/scores/playerY'
      expect(response.status).to eq(404)
    end

    it "retrieve score by ID witch is not present - status = 404" do
      get '/api/v1/scores/105678930330330303030'
      expect(response.status).to eq(404)
    end

    it "retrieve score by valid ID- status = 200" do
      id = @resp['data']['id']
      get "/api/v1/scores/#{id}"
      expect(response.status).to eq(200)
    end

  end

  describe "Delete Score" do
    before do
      post '/api/v1/scores', params: {player: 'playerX', score: Faker::Number.number(digits: 2), "time": Faker::Date.forward(days: 0)}
      @resp = JSON.parse(response.body)
    end

    it "delete score by player playerX code = 404" do
      delete '/api/v1/scores/playerX'
      expect(response.status).to eq(404)
    end

    it "Delete score by ID witch is not present code = 404" do
      delete '/api/v1/scores/12345678901298'
      expect(response.status).to eq(404)
    end

    it "delete score code = 200" do
      id = @resp['data']['id']
      delete "/api/v1/scores/#{id}"
      expect(response.status).to eq(200)
    end

  end

  describe "Get list of scores" do

    before do
      10.times do
        post '/api/v1/scores', params: {player: 'playerX', score: Faker::Number.number(digits: 2), "time": Faker::Date.forward(days: 0)}
        post '/api/v1/scores', params: {player: 'playerY', score: Faker::Number.number(digits: 2), "time": '2nd November 2020'}
        post '/api/v1/scores', params: {player: 'playerZ', score: Faker::Number.number(digits: 2), "time": '1st October 2020'}
      end
    end

    it "Get all scores by playerX" do
      get '/api/v1/scores', params: {player: 'playerX'}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['pagination']['total_count']).to eq(10)
    end

    it "Get all score after 1st November 2020" do
      get '/api/v1/scores', params: {after: '1st November 2020'}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['pagination']['total_count']).to eq(20)
    end

    it "Get all score before 1st December 2020" do
      get '/api/v1/scores', params: {before: '1st December 2020'}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['pagination']['total_count']).to eq(20)
    end

    it "Get all scores by playerX, playerY before 1st december 2020" do
      get '/api/v1/scores', params: {player: 'playerX, playerY', before: '1st December 2020'}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['pagination']['total_count']).to eq(10)
    end

    it "Get all scores after 1 Jan 2020 and before 1 Jan 2021" do
      get '/api/v1/scores', params: {before: '1 Jan 2021', after: '1 Jan 2020'}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['pagination']['total_count']).to eq(20)
    end

    it "Get all scores by playerX after 1 Jan 2020 and before 1 Jan 2021" do
      get '/api/v1/scores', params: {player: 'playerY', before: '1 Jan 2021', after: '1 Jan 2020'}
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['pagination']['total_count']).to eq(10)
    end

  end

  describe "Players history" do

    before do
      post '/api/v1/scores', params: {player: 'playerX', score: 5, "time": Faker::Date.forward(days: 0)}
      post '/api/v1/scores', params: {player: 'playerX', score: 10, "time": Faker::Date.forward(days: 0)}
      post '/api/v1/scores', params: {player: 'playerX', score: 15, "time": Faker::Date.forward(days: 0)}
      post '/api/v1/scores', params: {player: 'playerX', score: 20, "time": Faker::Date.forward(days: 0)}
      post '/api/v1/scores', params: {player: 'playerX', score: 25, "time": Faker::Date.forward(days: 0)}
    end

    it "list of top score" do
      get "/api/v1//scores/playerscorehistory/playerX/Top"
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['data']['score']).to eq(25)
    end

    it "list of low score" do
      get "/api/v1//scores/playerscorehistory/playerX/Low"
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['data']['score']).to eq(5)
    end

    it "list of average score" do
      get "/api/v1//scores/playerscorehistory/playerX/Average"
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['data']['score']).to eq("15.0")
    end

    it "list of all the scores of this player" do
      get "/api/v1//scores/playerscorehistory/playerX/All"
      resp = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(resp['data'].length).to eq(5)
    end

  end

end