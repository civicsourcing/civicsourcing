module Api
  module V1
    class CommentsController < ApplicationController
      # GET /comments
      # GET /comments.json
      def index
        @comments = Comment.where(QueryParams.new(Comment, params).build)

        render json: @comments
      end

      # GET /comments/1
      # GET /comments/1.json
      def show
        @comment = Comment.find(params[:id])

        render json: @comment
      end

      # POST /comments
      # POST /comments.json
      def create
        @comment = Comment.new(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render_validation_errors @comment.errors
        end
      end

      # PATCH/PUT /comments/1
      # PATCH/PUT /comments/1.json
      def update
        @comment = Comment.find(params[:id])

        authorize! :manage, @comment

        if @comment.update(comment_params)
          head :no_content
        else
          render_validation_errors @comment.errors
        end
      end

      # DELETE /comments/1
      # DELETE /comments/1.json
      def destroy
        @comment = Comment.find(params[:id])

        authorize! :manage, @comment
        
        @comment.destroy

        head :no_content
      end

      private
      def comment_params
        params.require(:comment).permit(:body, :parent_event_id).
          merge(user: current_user)
      end
    end
  end
end