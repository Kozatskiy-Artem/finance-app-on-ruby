require "test_helper"

class OperationTest < ActiveSupport::TestCase
  test "checking category name by operation with amount 999" do
    operation = Operation.find_by(amount: 999)
    assert_equal(operation.category.name, "Category_2")
  end

  test "return false if amount is empty" do
    new_operation = Operation.new(odate: 2023-03-25, category_id: 4, description: 'Pay for something')
    assert_not(new_operation.valid?, "Create the operation without a amount")
  end

  test "return false if amount is not numeric" do
    new_operation = Operation.new(amount: 'one hundreden', odate: 2023-03-25, category_id: 9, description: 'Pay for something')
    assert_not(new_operation.valid?, "Create the operation with amount is not numeric")
  end

  test "return false if odate is empty" do
    new_operation = Operation.new(amount: 100, category_id: 5, description: 'Pay for something')
    assert_not(new_operation.valid?, "Create the operation without a odate")
  end

  test "return false if description is empty" do
    new_operation = Operation.new(amount: 100, odate: 2023-03-25, category_id: 3)
    assert_not(new_operation.valid?, "Create the operation without a description")
  end

  test "return false if category_id is empty" do
    new_operation = Operation.new(amount: 100, odate: 2023-03-25, description: 'Pay for something')
    assert_not(new_operation.valid?, "Create the operation without a category_id")
  end

  test "will return true if everything is valid" do
    new_operation = Operation.new(amount: 100, odate: 2023-03-25, description: 'Pay for something')
    new_operation.category = categories(:five)
    assert(new_operation.valid?, "Create the operation with valid data")
  end
end
