module Api
  class RacesController < ApplicationController
    protect_from_forgery with: :null_session

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      @msg = "woops: cannot find race[#{params[:id]}]"
      if !request.accept || request.accept == "*/*"
        render plain: @msg, status: :not_found
      else
        render action: :error, :content_type => request.accept, status: :not_found
      end
    end

    rescue_from ActionView::MissingTemplate do |exception|
      @msg = "woops: we do not support that content-type[#{request.accept}]"
      Rails.logger.debug exception
      render plain: @msg, status: 415

    end


    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        #real implementation ...
        @race = Race.find(params[:id])
        #render json: @race, status: :ok, content_type: "application/json"
        if !@race.nil?
            render action: :show, :content_type => request.accept, status: :ok
        else
            render action: :error,:content_type => request.accept, status: :not_found
        end

      end
    end

    def create
      if !request.accept || request.accept == "*/*"
        render plain: "#{params[:race][:name]}", status: :ok
      else
        #real implementation
        @race = Race.new(race_params)
        @race.save
        render plain: "#{params[:race][:name]}", status: :created

      end
    end

    def update
      @race = Race.find(params[:id])
      @race.update(race_params)
      render json: @race, status: :ok
    end

    def destroy
      @race= Race.find(params[:id])
      @race.destroy
      render nothing: true, status: :no_content
    end

    private
      def race_params
        params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
      end

  end

end
