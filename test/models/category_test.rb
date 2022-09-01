require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup # run before every test
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do # -> using correct datatype validation from field from model
    assert @category.valid?
  end

  test "name should be present" do # -> using presence validation from model
    @category.name = ""
    assert_not @category.valid?
  end

  test "name should be unique" do # -> using unique validation from model
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?    # category is already have in db so it will return false-> intentionally test
  end

  test "name should not be too long" do #max length is 20 -> using length validation from model
    @category.name = "abcdefghijklmnoopqrstuvwxyz"
    assert_not @category.valid?
  end

  test "name should not be too small" do #min length is 3 -> using length validation from model
    @category.name = "ab"
    assert_not @category.valid?
  end

end