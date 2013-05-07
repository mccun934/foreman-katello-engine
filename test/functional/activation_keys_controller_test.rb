require 'test_helper'
require 'mocha/setup'

module ForemanKatelloEngine
  class ActivationKeysControllerTest < ActionController::TestCase

    before do
      setup_users
    end

    let :environment do
      ::Environment.create! do |env|
        env.name  = 'DevEnv'
        env.katello_id = 'ACME/Dev/CV1'
      end
    end

    let :aks_to_subscriptions_data do
      {"ak1" => ["prod1", "prod2"], "ak2" => ["prod3", "prod4"]}
    end

    describe "#index" do

      it "loads activation keys from Katello" do
        ForemanKatelloEngine::Bindings.expects(:activation_keys_to_subscriptions).
          with('ACME', 'Dev', 'CV1').returns(aks_to_subscriptions_data)
        get :index, { :environment_id => environment.id }, set_session_user
        assert_response :success
        assert_equal aks_to_subscriptions_data, JSON.parse(response.body)
      end

    end

  end
end
