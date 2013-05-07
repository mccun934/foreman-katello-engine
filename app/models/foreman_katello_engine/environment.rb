module ForemanKatelloEngine
  class Environment

    class Conflict < StandardError; end

    def self.find(org_label, env_label, content_view_label)
      katello_id = generate_katello_id(org_label, env_label, content_view_label)
      ::Environment.where(:katello_id => katello_id).first
    end

    def self.create!(org_label, env_label, content_view_label, content_view_id)
      katello_id = generate_katello_id(org_label, env_label, content_view_label)
      ::Environment.transaction do
        if existing_env = ::Environment.where(:katello_id => katello_id).first
          raise Conflict, "environment already exists: #{existing_env.id} - #{existing_env.name}"
        end
        ::Environment.create! do |env|
          env.name = generate_name(org_label, env_label, content_view_label, content_view_id)
          env.katello_id = katello_id
          yield env if block_given?
        end
      end
    end

    def self.generate_katello_id(org_label, env_label, content_view_label)
      raise ArgumentError, "org_label has to be specified" if org_label.blank?
      raise ArgumentError, "env_label has to be specified" if env_label.blank?
      [org_label, env_label, content_view_label].reject(&:blank?).join('/')
    end

    # content_view_id provides the uniqueness of the name
    def self.generate_name(org_label, env_label, content_view_label, content_view_id)
      name = ["KT", org_label, env_label, content_view_label, content_view_id].reject(&:blank?).join('_')
      return name.gsub('-','_')
    end


  end
end
