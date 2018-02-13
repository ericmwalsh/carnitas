module Exceptions
  BAD_REQUEST = 400
  UNAUTHORIZED = 401
  FORBIDDEN = 403
  NOT_FOUND = 404
  BAD_SAVE = 422
  BINANCE_LIMIT = 429

  class BadRequestError < StandardError
    attr_reader :status
    #
    def initialize(message = 'Bad Rquest', status = BAD_REQUEST)
      @status = status
      super(message)
    end
  end

  class UnauthorizedError < BadRequestError
    def initialize(message = 'Unauthorized')
      super(message, UNAUTHORIZED)
    end
  end

  class ForbiddenError < BadRequestError
    def initialize(message = 'Forbidden')
      super(message, FORBIDDEN)
    end
  end

  class NotFoundError < BadRequestError
    def initialize(message = 'Not Found')
      super(message, NOT_FOUND)
    end
  end

  class BinanceLimitError < BadRequestError
    def initialize(message = 'Binance Rate Limit reached')
      super(message, BINANCE_LIMIT)
    end
  end

  # {"key":["has already been taken"]}
  class BadSaveError < BadRequestError
    def initialize(record)
      message = record.nil? ? 'Bad Save' : error_messages(record)
      super(message, BAD_SAVE)
    end

    private

    def error_messages(record)
      record.map do |field, errors|
        "#{field.upcase} - #{errors.join(',')}"
      end.join('; ')
    end
  end
end
