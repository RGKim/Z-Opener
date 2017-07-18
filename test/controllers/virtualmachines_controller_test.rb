require 'test_helper'

class VirtualmachinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @virtualmachine = virtualmachines(:one)
  end

  test "should get index" do
    get virtualmachines_url
    assert_response :success
  end

  test "should get new" do
    get new_virtualmachine_url
    assert_response :success
  end

  test "should create virtualmachine" do
    assert_difference('Virtualmachine.count') do
      post virtualmachines_url, params: { virtualmachine: { datacenter: @virtualmachine.datacenter, description: @virtualmachine.description, price: @virtualmachine.price } }
    end

    assert_redirected_to virtualmachine_url(Virtualmachine.last)
  end

  test "should show virtualmachine" do
    get virtualmachine_url(@virtualmachine)
    assert_response :success
  end

  test "should get edit" do
    get edit_virtualmachine_url(@virtualmachine)
    assert_response :success
  end

  test "should update virtualmachine" do
    patch virtualmachine_url(@virtualmachine), params: { virtualmachine: { datacenter: @virtualmachine.datacenter, description: @virtualmachine.description, price: @virtualmachine.price } }
    assert_redirected_to virtualmachine_url(@virtualmachine)
  end

  test "should destroy virtualmachine" do
    assert_difference('Virtualmachine.count', -1) do
      delete virtualmachine_url(@virtualmachine)
    end

    assert_redirected_to virtualmachines_url
  end
end
