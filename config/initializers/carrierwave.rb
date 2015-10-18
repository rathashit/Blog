CarrierWave.configure do |config|
	config.fog_credentials = {
		provider: "AWS",
		aws_access_key_id: 'AKIAJ3NALMB7IO5KUH6A',
		aws_secret_access_key: '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',
		region: 'ap-southeast-1'
	}
	config.fog_directory = 'humblepostimages'
end