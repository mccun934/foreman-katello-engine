require 'test_helper'
require 'mocha/setup'

module ForemanKatelloEngine
  module Api
    class EnvironmentsControllerTest < ActionController::TestCase

      before do
        setup_users
        environment
      end

      let :environment do
        Environment.create! do |env|
          env.name  = 'DevEnv'
          env.kt_id = 'ACME/Dev/CV1'
        end
      end

      describe "#show" do

        it "show an environment based on Katello org, env and CV label" do
          # id => show means id is not really used
          get :show, { :id => "show", :org => 'ACME', :env => 'Dev', :cv => 'CV1' }, set_session_user
          assert_response :success
          response_env = JSON.parse(response.body)["environment"]
          response_env["id"].must_equal environment.id
        end

      end


      describe "#create" do

        it "creates an environment based on Katello org and env" do
          # id => show means id is not really used
          post :create, { :org => 'ACME', :env => 'Dev', :cv_id => 'env'}, set_session_user
          assert_response :success
          response_env = JSON.parse(response.body)["environment"]
          env = Environment.find(response_env["id"])
          env.name.must_equal "KT_ACME_Dev_env"
          env.kt_id.must_equal "ACME/Dev"
        end

        it "creates an environment based on Katello org, env and CV label" do
          post :create, { :org => 'ACME', :env => 'Dev', :cv => 'CV2', :cv_id => 2 }, set_session_user
          assert_response :success
          response_env = JSON.parse(response.body)["environment"]
          env = Environment.find(response_env["id"])
          env.name.must_equal "KT_ACME_Dev_CV2_2"
          env.kt_id.must_equal "ACME/Dev/CV2"
        end

        it "requires env to be set" do
          post :create, { :org => 'ACME'}, set_session_user
          assert_response 422
        end

        it "requires org to be set" do
          post :create, {}, set_session_user
          assert_response 422
        end

        it "refused to create the same env twice" do
          post :create, { :org => 'ACME', :env => 'Dev', :cv => 'CV1', :cv_id => 2 }, set_session_user
          assert_response 409
        end

      end

    end
  end
end
