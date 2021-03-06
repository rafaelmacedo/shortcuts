require "boot"

set :views,   File.dirname(__FILE__) + "/views"
set :public,  File.dirname(__FILE__) + "/static"

get "/api" do
  erb :api
end

get "/apps.json" do
  content_type :json
  {:apps => App.all}.to_json
end

get "/:app.json" do
  content_type :json

  @app = App.find_by_permalink!(params["app"])
  {:app => @app, :shortcuts => @app.shortcuts.sorted.all}.to_json
end

get "/:app" do
  @apps = [App.find_by_permalink(params["app"])].compact
  redirect("/") if @apps.empty?
  erb :index
end

get "/" do
  @apps = App.sort(:name)
  erb :index
end
