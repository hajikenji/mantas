# def index
#     session.delete(:text_in_search) if params[:reset_search_session]
    
    
#     # if params[:search_name].present?
#     #   session[:text_in_search] = "on"
#     # end
#     @status = params[:status]
#     @search_name = params[:search_name]
    

#     if session[:text_in_search].present? #name検索をしたら

#       if params[:search_name].present?
#         session[:text_in_search] = params[:search_name]
#         @tasks = Task.where('name like ?',"%#{session[:text_in_search]}%")
#       end

#       p 1
#       if params[:name] == "sort_time"
#         p 3
#         @tasks = Task.where('name like ?',"%#{session[:text_in_search]}%")
#         @tasks = @tasks.order_time
        
#       elsif params[:name] == 'sort_update'
#         @tasks = Task.where('name like ?',"%#{session[:text_in_search]}%")
#         @tasks = @tasks.order_update

#       end

#     else #name検索をしなかったら
#       p 2
#       if params[:name] == "sort_time"
#         @tasks = Task.order_time
#       elsif params[:name] == 'sort_update'
#         @tasks = Task.order_update
#       else
#         @tasks = Task.all
#       end

#     end

    
#     case params[:status]
#     when "0"
#       @tasks = Task.status_0_index
#     when "1"
#       @tasks = Task.status_1_index
#     when "2"
#       @tasks = Task.status_2_index

#     end

#   end

class User
  def initialize(name)
    @name = name 
  end

  # def self.create(names)
  #   names.map do |n|
  #     User.new(n)
  #   end
  # end
  def create(names)
    names.map do |n|
      User.new(n)
    end
  end
  # def hello
  #   "hello,#{@name}"
  # end
  def hello
    "hello,#{@name}"
  end
end

names = ['alice', 'bob', 'carol']
# users = User.create(names)
users = User.new('a')
users = users.create(names)

# users.each do |u|
#   p u.hello
# end
p users

users.each do |u|
  p u.hello
end