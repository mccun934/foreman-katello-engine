module ForemanKatelloEngine
  module HostsAndHostgroupsHelper

    def activation_key_input
      path = ""
      method = :activation_key
      options = {:class => "auto_complete_input"}
      completion_options = {}
      text_field_tag(method, nil, options) +
        auto_complete_clear_value_button(method) +
        auto_complete_field_jquery(method, "#{path}/auto_complete_#{method}", completion_options)
    end

    def kt_ak_label
      "kt_activation_keys"
    end

    def envs_by_kt_org
      ::Environment.all.find_all(&:katello_id).group_by do |env|
        if env.katello_id
          env.katello_id.split('/').first
        end
      end
    end

    def grouped_env_options
      grouped_options = envs_by_kt_org.sort_by(&:first).map do |kt_org_label, envs_by_org|
        optgroup = %[<optgroup label="#{kt_org_label}">]
        opts = envs_by_org.sort_by(&:katello_id).reduce({}) do |env_options, env|
          selected = env.id == (@host || @hostgroup).environment_id ? "selected" : nil
          kt_env_label = env.katello_id.split('/')[1]
          env_options[kt_env_label] ||= selected
          env_options
        end.sort_by(&:first).map do |kt_env_label, selected|
          %[<option value="#{kt_org_label}/#{kt_env_label}" class="kt-env" #{selected}>#{kt_env_label}</option>]
        end.join
        optgroup << opts
        optgroup << '</optgroup>'
      end.join
      grouped_options.insert(0, %[<option value=""></option>])
      grouped_options.html_safe
    end

    def content_view_options
      cv_options = ::Environment.order(:katello_id).all.map do |env|
        selected = env.id == (@host || @hostgroup).environment_id ? "selected" : ""
        env_text = env.katello_id ? env.katello_id.split('/')[2] : env.name
        %[<option value="#{env.id}" data-katello-id="#{env.katello_id}" #{selected}>#{env_text}</option>]
      end.join

      return cv_options.html_safe
    end

  end
end
