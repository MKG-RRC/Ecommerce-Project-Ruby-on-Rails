ActiveAdmin.register Category do
  # Disable filters (optional)
  config.filters = false

  permit_params :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end

    panel "Products in this Category" do
      table_for category.products do
        column :id
        column :name
        column :price
        column :created_at
      end
    end
  end
end
