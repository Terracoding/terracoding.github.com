# Middleman 3.x Image Resizer Extension
# by Sam Rayner
#
# In config.rb:
# require 'extensions/image_resizer'
# activate :image_resizer do |i|
#   i.input_folders = ['assets/images']
#   i.filename_suffix = '@1x'
# end

require 'mini_magick'

module ImageResizer

	class Options < Struct.new(:input_folders, :filename_suffix); end

	class << self
		def registered(app, options={}, &block)
			options = Options.new(options)
			yield options if block_given?

			app.after_build do |builder|
				options.input_folders.each do |folder|
					files = Dir.glob("source/#{folder}/**/*.{jpg,jpeg,png,JPG,JPEG,PNG}")

					files.each do |file|
						extension = File.extname(file)
            output_path = file.sub("source", build_dir)
              .sub(extension, "#{options.filename_suffix}#{extension}")
						image = MiniMagick::Image.open(file)
            image.resize '50%'
						image.write output_path
						builder.say_status :generated, output_path
					end
				end
			end
		end
		alias :included :registered
	end
end

::Middleman::Extensions.register(:image_resizer, ImageResizer)
