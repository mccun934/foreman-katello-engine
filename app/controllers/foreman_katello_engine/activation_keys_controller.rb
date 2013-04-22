module ForemanKatelloEngine
  class ActivationKeysController < ApplicationController
    def index
      environment = Environment.find_by_id(params[:environment_id])
      raise "Selected environment has now Katello connection" unless environment.kt_id
      kt_org_label, kt_env_label, kt_cv_label = environment.kt_id.split('/')

      ak_data = ForemanKatelloEngine::Bindings.activation_keys_to_subscriptions(kt_org_label, kt_env_label, kt_cv_label)
      render :status => 200, :json => ak_data, :content_type => 'application/json'
    end
  end
end
