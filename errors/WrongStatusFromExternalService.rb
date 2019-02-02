class WrongStatusFromExternalService < StandardError
  def initialize(message, status)
    msg = "Something went wrong with the external service. Status is #{status} . The message is #{message}"
    super(msg+" xujnja")
  end
end