# frozen_string_literal: true

class Comment < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :article

end
