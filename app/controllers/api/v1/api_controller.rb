class Api::V1::ApiController < ApplicationController
  require 'ostruct'

  def index
    @users = User.all
    @api = OpenStruct.new({ :version => "1.0", :last_response_time => 27})
  end
end