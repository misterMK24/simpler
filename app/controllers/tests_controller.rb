class TestsController < Simpler::Controller

  def index
    render json: 'tests/list'
    status 302
    headers['Content-Type'] = 'application/json'
    headers['Date'] = Time.now.to_s
  end

  def show
    render plain: params[:some_param]
  end

  def create

  end

end
