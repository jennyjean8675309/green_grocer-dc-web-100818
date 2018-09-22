require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |item_name, pricing_info|
      if consolidated_cart[item_name] == nil
        consolidated_cart[item_name] = pricing_info
        consolidated_cart[item_name][:count] = 1
      else
        consolidated_cart[item_name][:count] = consolidated_cart[item_name][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_item|
    if cart.include?(coupon_item[:item]) && cart[coupon_item[:item]][:count] >= coupon_item[:num]
      item_count_before_coupon = cart[coupon_item[:item]][:count]
      cart["#{coupon_item[:item]} W/COUPON"] = {:price => coupon_item[:cost], :clearance => cart[coupon_item[:item]][:clearance], :count => nil}
      cart[coupon_item[:item]][:count] = item_count_before_coupon % coupon_item[:num]
      cart["#{coupon_item[:item]} W/COUPON"][:count] = item_count_before_coupon / coupon_item[:num]
    else
       cart
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, pricing_info|
    if pricing_info[:clearance] == true
      clearance_discount = pricing_info[:price] * 0.20
      pricing_info[:price] = pricing_info[:price] - clearance_discount
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cartconsolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  cart_total = []
  cart.collect do |item, pricing_info|
    pricing_info[:price] * pricing_info[:count]
  end
  binding.pry
end
