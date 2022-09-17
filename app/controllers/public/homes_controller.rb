class Public::HomesController < ApplicationController

  def top
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(10).pluck(:tag_id))
  end

  def about
  end

end
