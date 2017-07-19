require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { bandwidth: @order.bandwidth, cpu: @order.cpu, domain: @order.domain, first_disk: @order.first_disk, hostname: @order.hostname, image_id: @order.image_id, location: @order.location, os: @order.os, ram: @order.ram, second_disk: @order.second_disk, usehourlypricing: @order.usehourlypricing } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { bandwidth: @order.bandwidth, cpu: @order.cpu, domain: @order.domain, first_disk: @order.first_disk, hostname: @order.hostname, image_id: @order.image_id, location: @order.location, os: @order.os, ram: @order.ram, second_disk: @order.second_disk, usehourlypricing: @order.usehourlypricing } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
