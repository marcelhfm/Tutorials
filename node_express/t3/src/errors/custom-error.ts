class CustomAPIError extends Error {
  constructor(message: string, statusCode: number) {
    super(message);
    statusCode = statusCode;
  }
}

module.exports = CustomAPIError;
