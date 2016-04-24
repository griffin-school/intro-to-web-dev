class ChannelsController < ApplicationController
  def index
    @channels = Channel.all
    respond_to do |format|
      format.html
      format.json { render json: @channels }
    end
  end

  def new
  end

  def show
    @channel = Channel.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @channel}
    end

  end

  def create
    puts session
    @channel = Channel.new(channel_params)

    saved = @channel.save
    respond_to do |format|
      format.html {
        if saved
           redirect_to @channel
        else
          render 'new'
        end
      }
      format.json {
        if saved
          render json: @channel
        else
          render json: { errors: @channel.errors}
        end
      }
    end

  end

  private
  def channel_params
    params.require(:channel).permit(:title, :description)
  end


end
