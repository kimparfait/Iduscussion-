class CommentsController < ApplicationController

	before_action :find_post
	 before_action :find_comment, only:[:edit, :update, :destroy ]
	 before_action :authenticate_user!, only: [:new, :edit]


	def new

		@comment= Comment.new

	end 

	def create 
		@comment= Comment.new(comment_params)
		@comment.post_id = @post.id
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to root_path
		else
			render'new'
		end

		end


	def edit
		@comment = Comment.find(params[:id])
	end 
	def update 
		if @comment.update(comment_params)
				redirect_to root_path
				else
				render'edit'
			end
	end 

	def destroy

		@comment.destroy
		redirect_to root_path
	end
	private 
		def comment_params
			params.require(:comment).permit(:comment)
			end

			def find_post
			@post= Post.find(params[:post_id])
		end
		def find_comment
			@comment = Comment.find(params[:id])

		end 
end
