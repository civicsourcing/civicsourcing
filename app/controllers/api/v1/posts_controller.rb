module Api
  module V1
    class PostsController < ApplicationController
      # GET /posts
      # GET /posts.json
      def index
        @posts = Post.where(QueryParams.new(Post, params).build)

        render json: @posts
      end

      # GET /posts/1
      # GET /posts/1.json
      def show
        @post = Post.find(params[:id])

        render json: @post
      end

      # POST /posts
      # POST /posts.json
      def create
        @post = Post.new(post_params)

        if @post.save
          render json: @post, status: :created
        else
          render_validation_errors @post.errors
        end
      end

      # PATCH/PUT /posts/1
      # PATCH/PUT /posts/1.json
      def update
        @post = Post.find(params[:id])

        authorize! :manage, @post

        if @post.update(post_params)
          head :no_content
        else
          render_validation_errors @post.errors
        end
      end

      # DELETE /posts/1
      # DELETE /posts/1.json
      def destroy
        @post = Post.find(params[:id])

        authorize! :manage, @post
        @post.destroy

        head :no_content
      end

      private
      def post_params
        params.require(:post).permit(:title, :body, :feed_id).
          merge(user: current_user)
      end
    end
  end
end