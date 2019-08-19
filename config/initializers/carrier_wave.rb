if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      region:                ENV['AWS_REGION'],
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      path_style:            true
    }
    config.fog_directory     = ENV['S3_BUCKET']
    config.fog_public        = true
    config.asset_host        = "https://s3-#{ENV['AWS_REGION']}.amazonaws.com/#{ENV['S3_BUCKET']}"
  end
end
