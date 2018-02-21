encryptor_array = []
count = ENV['ENCRYPTOR_COUNT'].to_i

(0..count).each do |x|
  (0..count).each do |y|
    encryptor_array.push [
      "#{x}#{y}",
      ::Utilities::Encryptor.new(
        ENV["ENCRYPTOR_KEY_#{x}"],
        ENV["ENCRYPTOR_SALT_#{y}"]
      )
    ]
  end
end

ENCRYPTOR = encryptor_array
