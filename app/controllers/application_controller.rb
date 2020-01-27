class ApplicationController < ActionController::Base

  def welcome
    render html: 'Hello World'
  end

end
