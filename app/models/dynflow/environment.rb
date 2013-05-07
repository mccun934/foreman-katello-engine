module Dynflow
  class Environment

    class Conflict < StandardError; end

    def self.find(org_label, env_label, cv_label)
      kt_id = generate_kt_id(org_label, env_label, cv_label)
      ::Environment.where(:kt_id => kt_id).first
    end

    def self.create!(org_label, env_label, cv_label, cv_id)
      kt_id = generate_kt_id(org_label, env_label, cv_label)
      ::Environment.transaction do
        if existing_env = ::Environment.where(:kt_id => kt_id).first
          raise Conflict, "environment already exists: #{existing_env.id} - #{existing_env.name}"
        end
        ::Environment.create! do |env|
          env.name = generate_name(org_label, env_label, cv_label, cv_id)
          env.kt_id = kt_id
          yield env if block_given?
        end
      end
    end

    def self.generate_kt_id(org_label, env_label, cv_label)
      raise ArgumentError, "org_label has to be specified" if org_label.blank?
      raise ArgumentError, "env_label has to be specified" if env_label.blank?
      [org_label, env_label, cv_label].reject(&:blank?).join('/')
    end

    # cv_id provides the uniqueness of the name
    def self.generate_name(org_label, env_label, cv_label, cv_id)
      name = ["KT", org_label, env_label, cv_label, cv_id].reject(&:blank?).join('_')
      return name.gsub('-','_')
    end


  end
end
