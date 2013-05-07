module ForemanKatelloEngine
  module Api
    class EnvironmentsController < ::Api::V2::BaseController

      def show
        @environment = Dynflow::Environment.find(params[:org], params[:env], params[:cv])
        if @environment
          render :template => "api/v1/environments/show"
        else
          render_error 'not_found', :status => :not_found
        end
      end

      def create
        begin
          @environment = Dynflow::Environment.create!(params[:org],
                                                      params[:env],
                                                      params[:cv],
                                                      params[:cv_id])
        rescue Dynflow::Environment::Conflict => e
          render_error 'standard_error', :status => 409, :locals => { :exception => e }
          return
        rescue ArgumentError => e
          render_error 'standard_error', :status => 422, :locals => { :exception => e }
          return
        end
        render :template => "api/v1/environments/show"
      end

    end
  end
end
