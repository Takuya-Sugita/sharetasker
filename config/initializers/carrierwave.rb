CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: <%= ENV["AWS_ACCESS_KEY"] %>,
      aws_secret_access_key: <%= ENV["AWS_SECRET_ACCESS_KEY"] %>,
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'sharetaskerbucket'
    config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/sharetaskerbucket"
    config.fog_public     = false
    config.cache_storage = :fog
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end 
end
