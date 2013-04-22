module ForemanKatelloEngine
  module Api
    class EnvironmentsController < ::Api::V2::BaseController

      class BadRequest < StandardError; end

      class Conflict < StandardError; end


      def show
        kt_id = self.kt_id(params[:org], params[:env], params[:cv])
        @environment = Environment.where(:kt_id => kt_id).first
        if @environment
          render :template => "api/v1/environments/show"
        else
          render_error 'not_found', :status => :not_found
        end
      end

      def create
        begin
          kt_id = self.kt_id(params[:org], params[:env], params[:cv])
        rescue BadRequest => e
          render_error 'standard_error', :status => 422, :locals => { :exception => e }
          return
        end
        Environment.transaction do
          if existing_env = Environment.where(:kt_id => kt_id).first
            e = Conflict.new("environment already exists: #{existing_env.id} - #{existing_env.name}")
            render_error 'standard_error', :status => 409, :locals => { :exception => e }
            return
          end
          @environment = Environment.new
          @environment.name = generate_env_name(params[:org],
                                                params[:env],
                                                params[:cv],
                                                params[:cv_id])

          @environment.kt_id = kt_id
          @environment.save!
        end
        render :template => "api/v1/environments/show"
      end

      protected

      def kt_id(org_label, env_label, cv_label)
        raise BadRequest, "org_label has to be specified" if org_label.blank?
        raise BadRequest, "env_label has to be specified" if env_label.blank?
        [org_label, env_label, cv_label].reject(&:blank?).join('/')
      end

      def generate_env_name(org_label, env_label, cv_label, cv_id)
        name = ["KT", org_label, env_label, cv_label, cv_id].reject(&:blank?).join('_')
        return name.gsub('-','_')
      end

    end
  end
end
