class ArticlesController < ApplicationController

	http_basic_authenticate_with name: "peter", password: "12345678", except: [:index, :show]
 
  def index
    @articles = Article.all
  end

	def new
		@article = Article.new # this creates a new instance variable
	end

	def create
		@article = Article.new(article_params) # initialize with attributes

		if @article.save # saves to DB
			redirect_to @article # redirect user to show article
		else
			render 'new'
		end
	# use render instead of redirect_to when save returns false. 
	# The render method is used so that the @article object is 
	# passed back to the new template when it is rendered. This 
	# rendering is done within the same request as the form 
	# submission, whereas the redirect_to will tell the browser 
	# to issue another request.
	end

	def show
  	@article = Article.find(params[:id])
	end

	def edit
  	@article = Article.find(params[:id])
	end

	def update
  	@article = Article.find(params[:id])
 
  	if @article.update(article_params)
    	redirect_to @article
  	else
    	render 'edit'
  	end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
 		
 		redirect_to articles_path
 	end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end

# Rails has several security features that help you write secure 
# applications, and you're running into one of them now. 
# This one is called strong_parameters, which requires us to 
# tell Rails exactly which parameters we want to accept in our 
# controllers. In this case, we want to allow the title and 
# text parameters, so add the new article_params method, and 
# change your create controller action to use it, like this:
private
	def article_params
		params.require(:article).permit(:title, :text)
	end
# Note that def article_params is private. This new approach 
# prevents an attacker from setting the model's attributes by 
# manipulating the hash passed to the model. 
end
