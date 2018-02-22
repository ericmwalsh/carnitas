module Exceptions
  BAD_REQUEST = 400
  UNAUTHORIZED = 401
  FORBIDDEN = 403
  NOT_FOUND = 404
  BAD_SAVE = 422
  RATE_LIMIT = 429
  API_INPUT = 400
  API_ERROR = 500
  API_STATUS_UNKNOWN = 504

  class BaseError < StandardError
    attr_reader :status
    #
    def initialize(message = 'Bad Request', status = BAD_REQUEST) # string, integer
      @status = status
      super(message)
    end

    private

    def ar_error_messages(record) # hash
      record.map do |field, errors|
        "#{field.upcase} - #{errors.join(',')}"
      end.join('; ')
    end

    # {"code"=>-2014, "msg"=>"API-key format invalid."}
    def binance_error_message(error_hash) # hash
      "Binance Error // Code #{error_hash['code']}: #{error_hash['msg']}"
    end

    # {"success"=>false, "message"=>"APIKEY_INVALID", "result"=>nil}
    def bittrex_error_message(response_hash) # hash
      "Bittrex Error // Message: #{response_hash['message']}"
    end

  end

  class UnauthorizedError < BaseError
    def initialize(message = 'Unauthorized') # string
      super(message, UNAUTHORIZED)
    end
  end

  class ForbiddenError < BaseError
    def initialize(message = 'Forbidden') # string
      super(message, FORBIDDEN)
    end
  end

  class NotFoundError < BaseError
    def initialize(message = 'Not Found') # string
      super(message, NOT_FOUND)
    end
  end

  class BadSaveError < BaseError
    def initialize(record) # hash
      message = record.nil? ? 'Bad Save' : ar_error_messages(record)
      super(message, BAD_SAVE)
    end
  end

  # 3rd party API exceptions/errors
  # base errors, 4 of them
  # input / rate_limit / server / unknown
  class ApiInputError < BaseError
    def initialize(message = 'API Input Invalid', status = API_INPUT) # string, integer
      super(message, status)
    end
  end

  class ApiRateLimitError < BaseError
    def initialize(message = 'API Rate Limit Reached', status = RATE_LIMIT) # string, integer
      super(message, status)
    end
  end

  class ApiServerError < BaseError
    def initialize(message = 'API Server Error', status = API_ERROR) # string, integer
      super(message, status)
    end
  end

  class ApiUnknownError < BaseError
    def initialize(message = 'API Response Status Unknown', status = API_STATUS_UNKNOWN) # string, integer
      super(message, status)
    end
  end

  # input errors

  # binance
  class BinanceApiInputError < ApiInputError
    def initialize(error_hash, error_code = API_INPUT) # hash, integer
      super(binance_error_message(error_hash), error_code)
    end
  end

  # bittrex
  class BittrexApiInputError < ApiInputError
    def initialize(error_hash, error_code = API_INPUT) # hash, integer
      super(bittrex_error_message(error_hash), error_code)
    end
  end

  # rate limit errors

  # binance
  class BinanceApiRateLimitError < ApiRateLimitError
    def initialize(error_hash, error_code = RATE_LIMIT)  # hash, integer
      super(binance_error_message(error_hash), error_code)
    end
  end

  # bittrex
  class BittrexApiRateLimitError < ApiRateLimitError
    def initialize(error_hash, error_code = RATE_LIMIT)  # hash, integer
      super(bittrex_error_message(error_hash), error_code)
    end
  end

  # api server errors

  # binance
  class BinanceApiServerError < ApiServerError
    def initialize(error_hash, error_code = API_ERROR) # hash, integer
      super(binance_error_message(error_hash), error_code)
    end
  end

  # bittrex
  class BittrexApiServerError < ApiServerError
    def initialize(error_hash, error_code = API_ERROR) # hash, integer
      super(bittrex_error_message(error_hash), error_code)
    end
  end

  # status unknown errors

  # binance
  class BinanceApiUnknownError < ApiUnknownError
    def initialize(error_hash, error_code = API_STATUS_UNKNOWN) # hash, integer
      super(binance_error_message(error_hash), error_code)
    end
  end

  # bittrex
  class BittrexApiUnknownError < ApiUnknownError
    def initialize(error_hash, error_code = API_STATUS_UNKNOWN) # hash, integer
      super(bittrex_error_message(error_hash), error_code)
    end
  end

end
