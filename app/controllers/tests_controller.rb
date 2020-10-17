class TestsController < Simpler::Controller

  def index
    # render 'tests/list'
    # @time = Time.now

    render json: 'tests/list'
    status 302
  end

  def create

  end

end
