class MenusController < ApplicationController
  def home
    @title = %(Home)
  end

  def contact
    @title = %(Contact us)
  end

  def about
    @title = %(About us)
  end

  def help
    @title = %(Help)
  end

end
