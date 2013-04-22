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
      Environment.all.find_all(&:kt_id).group_by do |env|
        if env.kt_id
          env.kt_id.split('/').first
        end
      end
    end

    def envs_by_kt_env(envs)
      envs.group_by do |env|
        env.kt_id.split('/')[1]
      end
    end

    def envs_without_kt_org
      envs_without_kt_org = Environment.all.reject(&:kt_id)
    end

    def envs_without_kt_org_options
      options_from_collection_for_select(envs_without_kt_org,
                                         :id,
                                         :to_label,
                                         (@host || @hostgroup).environment_id)
    end

    def grouped_env_options
      envs_by_org = envs_by_kt_org.reduce({}) do |hash, (org, envs)|
        hash.update(org => envs_by_kt_env(envs))
      end
      grouped_options = envs_by_org.sort_by(&:first).map do |org, envs_by_env|
        optgroup = %[<optgroup label="#{org}">]
        opts = envs_by_env.sort_by(&:first).map do |kt_env, envs|
          envs.sort_by(&:kt_id).map do |env|
            selected = env.id == (@host || @hostgroup).environment_id ? "selected" : ""
            if cv = env.kt_id.split('/')[2]
              %[<option value="#{env.id}" class="kt-cv" #{selected}>#{cv}</option>]
            else
              %[<option value="#{env.id}" class="kt-env" #{selected}>#{kt_env}</option>]
            end
          end.join
        end.join
        optgroup << opts
        optgroup << '</optgroup>'
      end.join

      return grouped_options.html_safe + envs_without_kt_org_options
    end

  end
end
