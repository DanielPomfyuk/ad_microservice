class DatabaseError < StandardError
  def initialize(message, status)
    @status = status
    msg = "Some problem with database. Status is #{@status} . The message is #{message}"
    super(msg)
  end
  def return_json
    {:message => self.message,:status => @status}.to_json
  end
end