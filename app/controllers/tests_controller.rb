class TestsController < Simpler::Controller

  def index
    render json: 'tests/list'
    status 302
    headers['Date'] = Time.now.to_s
  end

  def show
    render plain: params[:id]
  end

  def create
  end

end
