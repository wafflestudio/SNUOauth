module MySNU
  CONFIG = YAML.load_file(Rails.root.join("config/mysnu.yml"))[Rails.env]
  APP_ID = CONFIG['app_id']
  SECRET = CONFIG['secret_key']
end
