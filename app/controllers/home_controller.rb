class HomeController < ApplicationController
  def index
    gon.push({
                 :users => User.all
             })
  end
end
