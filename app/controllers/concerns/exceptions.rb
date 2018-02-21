module Exceptions
  BAD_REQUEST = 400
  UNAUTHORIZED = 401
  FORBIDDEN = 403
  NOT_FOUND = 404
  BAD_SAVE = 422
  RATE_LIMIT = 429
  API_INPUT = 400

  class BadRequestError < StandardError
    attr_reader :status
    #
    def initialize(message = 'Bad Request', status = BAD_REQUEST) # string, integer
      @status = status
      super(message)
    end
  end

  class UnauthorizedError < BadRequestError
    def initialize(message = 'Unauthorized') # string
      super(message, UNAUTHORIZED)
    end
  end

  class ForbiddenError < BadRequestError
    def initialize(message = 'Forbidden') # string
      super(message, FORBIDDEN)
    end
  end

  class NotFoundError < BadRequestError
    def initialize(message = 'Not Found') # string
      super(message, NOT_FOUND)
    end
  end

  class RateLimitError < BadRequestError
    def initialize(message = 'API Rate Limit reached') # string
      super(message, RATE_LIMIT)
    end
  end

  # {"key":["has already been taken"]}
  class BadSaveError < BadRequestError
    def initialize(record) # hash
      message = record.nil? ? 'Bad Save' : error_messages(record)
      super(message, BAD_SAVE)
    end

    private

    def error_messages(record) # hash
      record.map do |field, errors|
        "#{field.upcase} - #{errors.join(',')}"
      end.join('; ')
    end
  end

  # 3rd party API exceptions/errors
  class ApiInputError < BadRequestError
    def initialize(message = 'API Input Invalid') # string
      super(message, API_INPUT)
    end
  end

  # Binance Errors
  class BinanceApiError < BadRequestError
    def initialize(error_hash, error_code) # hash, integer
      super(error_message(error_hash), error_code)
    end

    private
    # {"code"=>-2014, "msg"=>"API-key format invalid."}
    def error_message(error_hash) # hash
      "Code #{error_hash['code']}: #{error_hash['msg']}"
    end
  end

  class BinanceApiInputError < BinanceApiError
  end

  class BinanceApiUnknownError < BinanceApiError
  end

  class BinanceApiRateLimitError < BinanceApiError
    def initialize(error_hash, error_code = RATE_LIMIT)  # hash, integer
      super(error_message(error_hash), error_code)
    end
  end


end
