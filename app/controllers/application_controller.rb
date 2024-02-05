class ApplicationController < ActionController::Base
    include Authentication

    before_action :authenticated!
end
