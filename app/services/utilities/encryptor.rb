module Utilities
  class Encryptor
    # create key/salt rotation system to ensure added security
    KEY = ENV['ENCRYPTOR_KEY_0']
    SALT = ENV['ENCRYPTOR_SALT_0']

    class << self

      def encrypt(value)
        ::ENCRYPTOR.encrypt_and_sign(value)
      end

      def decrypt(value)
        ::ENCRYPTOR.decrypt_and_verify(value)
      end

      def generate_encryptor
        passphrase = ActiveSupport::KeyGenerator.new(KEY).generate_key(SALT, 32)
        ActiveSupport::MessageEncryptor.new(passphrase)
      end

    end
  end
end
