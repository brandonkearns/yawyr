class ShelvesController < ApplicationController
  before_action :set_shelf,      only:   [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

end
