class Api::V1::ProductCategoriesController < Api::V1::ApiController
  before_action :product_category_find, only: %i[show update destroy]
  
  def show
  end
  
  def create
    ProductCategory.create!(product_category_params)
    head 201
  end

  def update
    @product_category.update!(product_category_params)
    head 202
  end

  def destroy
    @product_category.destroy!
    head 204
  end
  
  private

  def product_category_find
    @product_category = ProductCategory.find_by!(code: params[:code])
  end

  def product_category_params
    params
      .require(:product_category)
      .permit(:name, :code)
  end

end