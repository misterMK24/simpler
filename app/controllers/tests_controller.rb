class TestsController < Simpler::Controller

  def index
    # render 'tests/list'
    # @time = Time.now

    render json: 'tests/list'
    status 302
    headers['Content-Type'] = 'application/json'
    headers['Date'] = Time.now.to_s
  end

  def create

  end

end
