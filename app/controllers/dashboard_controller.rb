class DashboardController < ApplicationController

  before_action :authenticate_user!

  def index
     #@posts = current_user.posts.all

    @posts = Post.all.ordenados.paginate(page:params[:page],per_page:10)


     @comment = Comment.new

     #@comments = Comment.all

  end
end
