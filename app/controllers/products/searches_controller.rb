class Products::SearchesController < ApplicationController
  before_action :set_ransack

  def index
    
    @products = @q.result(distinct: true).page(params[:page]).per(5) 
    @keyword = (search_params[:name_cont])
  end

  private
  def set_ransack
    @q = Product.ransack(params[:q])
  end
  def search_params
    params.require(:q).permit(:sorts,:search_order,:name_cont,:brand_cont,:size_id_eq,:status_eq,:postage_eq,:purchase_status_id_eq,:category_grandparent_id_eq,:category_parent_id_eq,:category_id_eq,:price_lteq,:price_gteq,:prefecture_eq)
  end
end
