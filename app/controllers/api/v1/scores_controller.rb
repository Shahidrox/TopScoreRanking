class Api::V1::ScoresController < ApplicationController
  protect_from_forgery
  before_action :set_player_by_id, only: [:destroy, :show]
  before_action :set_player_by_name, only: [:player_history]
  before_action :set_page, only: [:index]

  include Pagination
  DEFAULT_PAGE = 1
  DEFAULT_PAGE_SIZE = 50

  def index
    begin
      if is_valid_rec?
        rec = []
        score = Score.search(params).page(@page).per(@size)
        pages  = pagination(score)
        score.map{|score| rec << {player: score.player, score: score.score, time: score.time}}
        render status: 200, json: {status: 200, message: 'success', data: rec, pagination: pages}
      else
        render status: 400, json: {status: 400, message: 'bad request'}
      end
    rescue => e
      render status: 500, json: {status: 500, message: e}
    end
  end

  def create
    begin
      score = Score.new(score_params)
      if score.valid?
        score.save
        render status: 200, json: {status: 200, message: 'score successfully added', data: {id: score.id, player: score.player, score: score.score, time: score.time}}
      else
        render status: 400, json: {status: 400, message: score.errors.full_messages}
      end
    rescue => e
      render status: 500, json: {status: 500, message: e}
    end
  end

  def show
    if @score.present?
      render status: 200, json: {status: 200, message: 'success', data: {id: @score.id, player: @score.player, score: @score.score, time: @score.time}}
    else
      render status: 404, json: {status: 404, message: 'Record not avaleble'}
    end
  end

  def destroy
    begin
      score = Score.find_by(id: params[:id])
      if score.present?
        if score.delete
          render status: 200, json: {status: 200, message: 'score successfully deleted', data: {}}
        else
          render status: 400, json: {status: 400, message: 'Somthing went wrong'}
        end
      else
        render status: 404, json: {status: 404, message: 'Record not avaleble'}
      end
    rescue => e
      render status: 500, json: {status: 500, message: 'Somthing went wrong'}
    end
  end

  def player_history
    if @score.present?
      missing_params = false
      res = {}
      case params[:score].downcase
      when "top"
        score = @score.max_score
        res = {score: score.first.score, time: score.first.time}
      when "low"
        score = @score.min_score
        res = {score: score.first.score, time: score.first.time}
      when "average"
        avrg = @score.average(:score)
        res = {score: avrg, time: @score.last.time}
      when "all"
        res = []
        @score.map{|score| res << {score: score.score, time: score.time}}
      else
        missing_params = true
      end
      render status: 400, json: {status: 400, message: 'bad request'} if missing_params
      render status: 200, json: {status: 200, message: 'success', data: res} unless missing_params
    else
      render status: 404, json: {status: 404, message: 'Record not avaleble'}
    end
  end

  private

  def score_params
    params[:time] = params[:time].to_datetime
    params.permit(:player, :score, :time)
  end

  def set_player_by_id
    @score = Score.find_by(id: params[:id])
  end

  def set_player_by_name
    @score = Score.where('lower(player) = ?', params[:player].strip.downcase)
  end

  def set_page
    @page = params[:page].present? ? params[:page].to_i : DEFAULT_PAGE
    @size = params[:size].present? ? params[:size].to_i : DEFAULT_PAGE_SIZE
  end

  def is_valid_rec?
    return (params[:player].present? || params[:before].present? || params[:after].present? || params[:from_date].present? )|| params[:to_date].present?
  end
end