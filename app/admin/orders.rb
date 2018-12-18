ActiveAdmin.register Order do
  permit_params :owner, :order_items

  form do |f|
    f.inputs do
      f.input :owner_id
      f.input :order_items
    end
    f.actions
  end
end
