# ::Utilities::Encryptor
# https://www.cookieshq.co.uk/posts/encrypting-secrets-with-rails
module Utilities
  class Encryptor < ::ActiveSupport::MessageEncryptor
    def initialize(key, salt) # string, string
      passphrase = ActiveSupport::KeyGenerator.new(key).generate_key(salt, 32)
      super(passphrase)
    end

    class << self

      def encrypt(value)
        encryptor = ::ENCRYPTOR
          .sample
        [
          encryptor[0],
          encryptor[1].encrypt_and_sign(value)
        ]
      end

      def decrypt(value, encryptor)
        ::ENCRYPTOR
          .find{|encryptor_arr| encryptor_arr[0] == encryptor}
          .last
          .decrypt_and_verify(value)
      end

      def encryptor
        '00'
      end

    end
  end
end
