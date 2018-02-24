module Exceptions
  BAD_REQUEST = 400
  UNAUTHORIZED = 401
  FORBIDDEN = 403
  NOT_FOUND = 404
  BAD_SAVE = 422
  RATE_LIMIT = 429

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

  class ApiRateLimitError < BaseError
    def initialize(message = 'API Rate Limit Reached', status = RATE_LIMIT) # string, integer
      super(message, status)
    end
  end

end
