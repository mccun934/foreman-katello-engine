require 'katello_api'

module ForemanKatelloEngine
  module Bindings

    class << self

      def client_config
        {
          :base_url => Setting['katello_url'],
          :enable_validations => false,
          :oauth => {
            :consumer_key => Setting['oauth_consumer_key'],
            :consumer_secret => Setting['oauth_consumer_secret']
          }
        }
      end

      def environment
        KatelloApi::Resources::Environment.new(client_config)
      end

      def content_view
        KatelloApi::Resources::ContentView.new(client_config)
      end

      def activation_key
        KatelloApi::Resources::ActivationKey.new(client_config)
      end

      def activation_keys_to_subscriptions(org_label, env_label, content_view_label = nil)
        ak_query = {}
        if content_view_label
          content_views, _ = self.content_view.index('organization_id' => org_label,
                                                     'label' => content_view_label)
          if content_view = content_views.first
            ak_query['content_view_id'] = content_view['id']
          end
        end
        environments, _ = self.environment.index('organization_id' => org_label, 'name' => env_label)
        if environment = environments.first
          ak_query['environment_id'] = environment['id']
        end
        if ak_query.any?
          activation_keys, _ = self.activation_key.index(ak_query)
          return activation_keys.reduce({}) do |h, ak|
            h.update(ak['name'] => ak['pools'].map { |pool| pool['productName'] })
          end
        else
          return nil
        end
      end

    end
  end

end


