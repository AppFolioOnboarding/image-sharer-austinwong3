class ImagesController < ApplicationController
  def index
    @images = Image.order(created_at: :desc)
    @images = Image.tagged_with(tag).order(created_at: :desc) if tag
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      render :new
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy!

    redirect_to root_path
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end

  def tag
    params.permit(:tag)&.dig(:tag)
  end
end
