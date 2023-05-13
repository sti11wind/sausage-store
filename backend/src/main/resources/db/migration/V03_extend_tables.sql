create INDEX  idx_product_id on product (id);
create INDEX  idx_product_price on product (price);
create INDEX  idx_order_product_id on order_product (product_id);
create INDEX  idx_order_order_id on order_product (order_id);
