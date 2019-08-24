if Rails.env.production?
  bucket = ENV.fetch('S3_BUCKET') { '' }
  region = ENV.fetch('AWS_REGION') { '' }
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      region:                ENV.fetch('AWS_REGION') { '' },
      aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID') { '' },
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY') { '' },
      path_style:            true
    }
    config.fog_directory     = bucket
    config.fog_public        = true
    config.asset_host        = "https://s3-#{region}.amazonaws.com/#{bucket}"
  end
end
