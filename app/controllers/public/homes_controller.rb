class Public::HomesController < ApplicationController

  def top
    @tag_list = Tag.all
  end

  def about
  end

end
