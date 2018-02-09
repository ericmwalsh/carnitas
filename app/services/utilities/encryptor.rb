# ::Utilities::Encryptor
# https://www.cookieshq.co.uk/posts/encrypting-secrets-with-rails
module Utilities
  class Encryptor < ::ActiveSupport::MessageEncryptor
    # create key/salt rotation system to ensure added security
    KEY = ENV['ENCRYPTOR_KEY_0']
    SALT = ENV['ENCRYPTOR_SALT_0']

    def initialize
      passphrase = ActiveSupport::KeyGenerator.new(KEY).generate_key(SALT, 32)
      super(passphrase)
    end

    class << self

      def encrypt(value)
        ::ENCRYPTOR.encrypt_and_sign(value)
      end

      def decrypt(value)
        ::ENCRYPTOR.decrypt_and_verify(value)
      end

      def encryptor
        '00'
      end

    end
  end
end
