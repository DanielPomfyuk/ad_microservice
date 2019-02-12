class WrongStatusFromExternalService < StandardError
  def initialize(message, status)
    @status = status
    msg = "Something went wrong with the external service. Status is #{@status} . The message is #{message}"
    super(msg)
  end
  def return_json
    {:message => self.message,:status => @status}.to_json
  end
end