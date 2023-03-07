require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "check the 'Category_7' description" do
    category_seven = Category.find_by(name: 'Category_7')
    assert_equal("MyString_7", category_seven.description)
  end

  test "return false if name is empty" do
    new_category = Category.new(description: 'Something')
    assert_not(new_category.valid?, "Create the category without a name")
  end

  test "return false if new_category is not unique" do
    new_category = Category.new(name: 'Category_5', description: 'Something')
    assert_not(new_category.valid?, "Create the category with not unique name")
  end

  test "return false if description is empty" do
    new_category = Category.new(name: 'Category_5')
    assert_not(new_category.valid?, "Create the category without a description")
  end

  test "will return true if everything is valid" do
    new_category = Category.new(name: 'New_category', description: 'Something')
    assert(new_category.valid?, "Create the category with valid data")
  end
end
