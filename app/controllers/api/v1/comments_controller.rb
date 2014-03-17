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
          parent = FlexibleFeeds::Event.find(params[:comment][:parent_event_id])
          @comment.child_of(parent)
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      # PATCH/PUT /comments/1.json
      def update
        @comment = Comment.find(params[:id])

        if @comment.update(comment_params)
          head :no_content
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /comments/1
      # DELETE /comments/1.json
      def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy

        head :no_content
      end

      private
      def comment_params
        params.require(:comment).permit(:body).
          merge(commenter: current_user)
      end
    end
  end
end