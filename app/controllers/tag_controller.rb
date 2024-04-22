# frozen_string_literal: true

class TagController < ApplicationController
  def search
    name = params[:name]
    @tags = Tag.where("name LIKE ?", name).limit(4)
  end
end
